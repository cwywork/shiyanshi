<?php 

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Request;

class Index extends Controller
{
    public function index(Request $request)
    {
        header("location: /adm/");return;
    }
}
