<?php 
namespace App\Http\Controllers;
use Validator;
use Closure;
use Illuminate\Http\Request;
use Firebase\JWT\JWT;

class Mfile extends Controller
{
    protected $user;

    public function __construct()
    {
        $this->user = app('user');
    }

    /**
     * 上传文件
     */
    public function upload(Request $request)
    {
        $file = current($_FILES);
        $info = pathinfo($file['name']);
        $extension = $info['extension'] ?: '';
        $extension = strtolower($extension);
        if($file['size'] > 200*1024*1024) return response()->json(['code' => 'ERR_FILE_TOO_LARGE'], 400);
        return $this->saveFile($file, $extension);
    }

    private function saveFile($file, string $format)
    {
        $root   = explode('app', __DIR__);
        $root   = $root[0].'public';
        $durl   = '/files/assets/m_'.date('ym').'/d_'.date('d').'/';
        $flag   = $this->mkdirs($root.$durl);
        if(!$flag) return response()->json(['code' => 'ERR_MKDIR_FAILED'], 400);
        $f_name = uniqid().'.'.$format;
        $temp = move_uploaded_file($file['tmp_name'], $root.$durl.$f_name);
        $arr['url']     = $durl.$f_name;
        $arr['name']    = $file['name'];
        return response()->json($arr, 200);
    }

    public function delFile()
    {
        $mid = intval($this->input->post('m_id'));
        if($mid <= 0) R(41001, '参数错误');
        $row = $this->db->select('url')->get_where('check_files',array('id'=>$mid))->row();
        if(isset($row->url)){
            $root = BASEPATH.'../web_root/';
            if(file_exists($root.$row->url)) unlink($root.$row->url);
            $tmp = $this->db->delete('check_files',array('id'=>$mid));
            if($tmp){
                R(0);
            }else{
                R(41002,'删除文件失败');
            }
        }else{
            R(41003,'删除项未找到');
        }
    }

    private function checkFormat(string $format)
    {   
        $flag = false;
        switch ($format) {
            case 'gif':
                $flag = true;
                break;
            case 'jpg':
                $flag = true;
                break;
            case 'png':
                $flag = true;
                break;
            case 'jpeg':
                $flag = true;
                break;
            case 'bmp':
                $flag = true;
                break;
            default:
                break;
        }
        return $flag;
    }
}
