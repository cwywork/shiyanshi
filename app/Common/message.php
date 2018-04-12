<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 18-4-12
 * Time: 下午3:19
 */
if (! function_exists('def_messages')) {
    /**
     * 批量定义错误信息
     * @param  array  $define 常量和值的数组
     * @return void
     */
    function def_messages()
    {
        $message=[
            'required'  => 'ERR_PARAM_:attribute_REQUIRED',
            'min'       => 'ERR_PARAM_:attribute_INVALID',
            'max'       => 'ERR_PARAM_:attribute_INVALID',
            'regex'     => 'ERR_PARAM_:attribute_INVALID',
            'numeric'   => 'ERR_PARAM_:attribute_INVALID',
            'string'   => 'ERR_PARAM_:attribute_STRING'
        ];
        return $message;
    }
}