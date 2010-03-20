<?php

function utf8_array_encode($input)
{
    $return = array();

    foreach ($input as $key => $val)
    {
        if( is_array($val) ){ $return[$key] = utf8_array_encode($val); }
        else { $return[$key] = utf8_encode($val); }
    }
    return $return;          
} 


function utf8_array_decode($input)
{
    $return = array();

    foreach ($input as $key => $val)
    {
        if( is_array($val) ){ $return[$key] = utf8_array_decode($val); }
        else { $return[$key] = utf8_decode($val); }
    }
    return $return;          
} 


?>