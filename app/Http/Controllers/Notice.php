<?php 
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Firebase\JWT\JWT;

class Notice extends Controller
{
    protected $user;

    public function __construct()
    {
        $this->user = app('user');
    }

    /**
     * 获取文章列表
     */
    public function getNotices(Request $request)
    {
        $rules = [
            'skip'          => 'required|numeric',
            'limit'         => 'required|numeric',
            'category_id'   => 'numeric',
            'keywords'      => '',
            'status'        => 'in:1,2,3'
        ];

        $messages = [
            'required'      => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'         => 'ERR_PARAM_:attribute_INVALID',
            'numeric'       => 'ERR_PARAM_:attribute_INVALID',
            'status'        => 'ERR_PARAM_:attribute_INVALID',
        ];

        $attributes = [
            'skip'          => 'SKIP',
            'limit'         => 'LIMIT',
            'category_id'   => 'CATEGORYID',
            'keywords'      => 'KEYWORDS',
            'status'        => 'STATUS',
        ];
        $validator  = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params     = $request->only('keywords', 'skip' , 'limit', 'category_id');
        $params     = (object)array_filter($params, function($v){return !is_null($v);});
        $params->keywords = trim($params->keywords);
        $where = ' 1 ';
        $wVaule = [];
        //整合查询条件
        if(isset($params->category_id) && intval($params->category_id) > 0) {
            $where .= ' and c.category_id = ?';
            $wVaule[] = $params->category_id;
        }
        if(isset($params->keywords) && !empty($params->keywords)) {
            $where .= ' and c.title like ?';
            $wVaule[] = "%{$params->keywords}%";
        }
        if(isset($params->status) && !empty($params->status)) {
            $where .= ' and c.status = ?';
            $wVaule[] = "%{$params->status}%";
        }
        $sqlc = "SELECT count(1) jcount FROM cms_contents c 
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id
                WHERE ".$where;
        //获取总条数
        $total = DB::select($sqlc, $wVaule);
        if(!$total) return response()->json(['total' => 0, 'data'  => []], 200);
        //获取贫困户列表
        $sqld = "SELECT c.*, cc.name category_name FROM cms_contents c
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id 
                WHERE ".$where." limit ".$params->skip." , ".$params->limit;
        $data   = DB::select($sqld, $wVaule);
        $data   = ['total' => $total[0]->jcount, 'data'  => $data];
        return response()->json($data, 200);
    }

    public function getNoticesOne(Request $request, int $id)
    {
        $sql = "SELECT c.*, cc.name category_name FROM cms_contents c
                    LEFT JOIN cms_categorys cc ON c.category_id = cc.id 
                WHERE c.id=?";
        $find = DB::select($sql, [$id]);
        if(!isset($find[0]))  return response()->json(['code'=>'ERR_NOT_FIND'], 404);
        return response()->json($find[0], 200);
    }

   /**
     * 新增一条文章
     */
    public function insertNotice(Request $request) 
    {
        $rules = [
            'category_id'       => 'required|numeric',
            'source'            => 'max:32',
            'published_at'      => '',
            'title'             => 'required',
            'author'            => 'max:16',
            'status'            => 'in:1,2',
            'content'           => ''
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'in'                => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'category_id'       => 'CATEGORYID',
            'source'            => 'SOURCE',
            'published_at'      => 'PUBLISHEDAT',
            'title'             => 'TITLE',
            'author'            => 'AUTHOR',
            'status'            => 'STATUS',
            'content'           => 'CONTENT'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = (object)$request->only('category_id', 'source', 'published_at', 'title', 'author', 'content','status');
        if(isset($params->published_at)) {
            $params->published_by    = $this->user->id;
            $params->published_at    = strtotime($params->published_at);
        }
        $params->posted_at       =  time();
        $params->posted_by       =  $this->user->id;
        //判断家庭成方是否存在
        
        $data   = json_decode(json_encode($params), true);
        $newId  = DB::table('cms_contents')->insertGetId($data);
        return response()->json(['id'=>$newId], 200);
    }

    /**
     * 修改一条文章
     */
    public function updateNotice(Request $request, int $id) 
    {
        $rules = [
            'category_id'       => 'numeric',
            'source'            => 'max:32',
            'published_at'      => '',
            'title'             => 'max:64',
            'author'            => 'max:16',
            'status'            => 'numeric',
            'content'           => ''
        ];

        $messages = [
            'required'          => 'ERR_PARAM_:attribute_REQUIRED',
            'regex'             => 'ERR_PARAM_:attribute_INVALID',
            'numeric'           => 'ERR_PARAM_:attribute_INVALID'
        ];

        $attributes = [
            'category_id'       => 'CATEGORYID',
            'source'            => 'SOURCE',
            'published_at'      => 'PUBLISHEDAT',
            'title'             => 'TITLE',
            'author'            => 'AUTHOR',
            'status'            => 'STATUS',
            'content'           => 'CONTENT'
        ];

        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }
        $params = $request->only('category_id', 'source', 'published_at', 'title', 'author', 'status', 'content');
        $params = (object)array_filter($params, function($v){return !is_null($v);});
        if(isset($params->published_at)) {
            $params->published_by    = $this->user->id;
            $params->published_at    = strtotime($params->published_at);
        }
        //判断政策是否存在
        $find = DB::table('cms_contents')->where('id', $id)->count();
        if(!$find) return response()->json(['code' => 'ERR_NOTICE_NOT_EXISTS'], 404);
        $data   = json_decode(json_encode($params), true);
        DB::table('cms_contents')->where('id', $id)->update($data);
        return response()->json([], 200);
    }

    /**
     * 删除一条文章
     */
    public function deleteNotice(Request $request, int $id) 
    {
        $find = DB::table('cms_contents')->where('id', $id)->count();
        if(!$find) return response()->json(['code' => 'ERR_NOTICE_NOT_EXISTS'], 404);
        $flog = DB::table('cms_contents')->where('id', $id)->delete();
        return response()->json([], 200);
    }

    /**
     * 发布一条文章
     */
    public function publishNotice(Request $request, int $id) 
    {
        $find = DB::table('cms_contents')->where('id', $id)->count();
        if(!$find) return response()->json(['code' => 'ERR_NOTICE_NOT_EXISTS'], 404);
        $data['published_at'] = time();
        $data['published_by'] = $this->user->id;
        $flog = DB::table('cms_contents')->where('id', $id)->update($data);
        $code   = $flog ? 200 : 500;
        return response()->json([], $code);
    }

    /**
     * 首页轮播图存储接口
     */
    public function saveCarousel(Request $request)
    {
        $data = array_filter($request->all(), 'is_array');
        $this->cfile($data);
        return response()->json($data, 200);
    }

    /**
     * 首页轮播图存储接口
     */
    public function getCarousel(Request $request)
    {
        $data = $this->rfile();
        $data = empty($data) ? [] : json_decode($data, true);
        return response()->json($data, 200);
    }

    /**
     * 首页轮播图获取接口
     */
    public function rfile()
    {
        
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files';
        $file       = $dir.'/carousel.json';
        if(is_file($file)) {
            return file_get_contents($file);
        }
        return false;
    }

    public function cfile($data)
    {
        $dirRoot    = explode('app', __DIR__);
        $dir        = $dirRoot[0].'/files';
        $file       = $dir.'/carousel.json';
        if(!is_dir($dir)) $this->mkdirs($dir);
        $file = fopen($file, "w");
        $flog = fwrite( $file, json_encode($data));
        fclose($file);
        return $flog;
    }
}
