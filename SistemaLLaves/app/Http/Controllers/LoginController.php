<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
include 'konect.php';

class LoginController extends Controller
{

    function borrame(){
        return \PDO::getAvailableDrivers();
    }
}
