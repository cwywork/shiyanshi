<?php

namespace App\Http\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Validator;
class Schools extends Model
{
    //
    protected $table = 'schools';

    public function schoolsAll($request){
        $rules = [
            'sch_type_id'   => 'numeric',
            'sch_name'          =>'string'
//          'sch_type_id'   => 'required|numeric'
        ];

        $messages = def_messages();

        $attributes = [
            'sch_type_id'  => 'SCH_TYPE_ID',
            'sch_name'  => 'SCH_NAME'
        ];
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        if($validator->fails()) {
            return response()->json(['code' => $validator->errors()->first()], 400);
        }

        $params=$request->only('sch_type_id','sch_name');
        $params = (object)array_filter($params, function($v){return !is_null($v);});  //把不为空的值返回
        $where="1=1";
        if(!empty($params->sch_type_id)) {
            $where .=" and sch_type_id = ".$params->sch_type_id;
        }
        if(!empty($params->sch_name)) {
            $where .=" and sch_name like '%{$params->sch_name}%'";
        }
        $sql="select * from ".$this->table." where ".$where;
        return DB::select($sql);
    }
}
