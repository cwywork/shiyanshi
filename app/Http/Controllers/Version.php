<?php 
namespace App\Http\Controllers;
use Validator;
use Excel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Version extends Controller
{
    protected $request;
    public function __construct(Request $request)
    {}

    public function getVersion(Request $request)
    {
        $data = ['code' => 1];
        return response()->json($data, 200);
    }
}