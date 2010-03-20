<?php
/*
 Copyright 2010 Erwan Jegouzo
 Licensed under the Apache License, Version 2.0 (the "License"); 
 you may not use this file except in compliance with the License. 
 You may obtain a copy of the License at 
 http://www.apache.org/licenses/LICENSE-2.0 
 Unless required by applicable law or agreed to in writing, software 
 distributed under the License is distributed on an "AS IS" BASIS, 
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 See the License for the specific language governing permissions and 
 limitations under the License. 
 */
 
// Get XML from Flash's POST.
$xmlString = file_get_contents("php://input");

if(validXMLString($xmlString)){

	header('Content-Type: text/xml');
	header('Cache-Control: no-store');

	$xml = simplexml_load_string($xmlString);
	if(!empty($xml)){
		include("../../../wp-config.php");
		callFunction($xml);
	}
}


function validXMLString($xml){
	
	$error = false;
	
	$post_arr		=implode('.',$_POST);
	$get_arr		=implode('.',$_GET);
	$cook_arr		=implode('.',$_COOKIE);
	$post_arr_key	=implode('.',@array_flip($_POST));
	$get_arr_key	=implode('.',@array_flip($_GET));
	$cook_arr_key	=implode('.',@array_flip($_COOKIE));
	$other_shtuki	=@file_get_contents('php://input');
	$cracktrack 	=strtolower($post_arr.$get_arr.$cook_arr.$post_arr_key.$get_arr_key.$cook_arr_key.$other_shtuki);
	$wormprotector 	=array('base64','user_pass','union','select','substring','or id=', 'wp_users');
	$checkworm 		=str_replace($wormprotector, '*', $cracktrack);
	if ($cracktrack != $checkworm) {$error = true;}

	if(!preg_match('/<press2flash>/', $xml)){
		$error = true;
	}	
	
	if($error){return false;}
	
	return true;

}

function callFunction($xml){
	$callFunction =  $xml->call['callFunction'];
	switch($callFunction){
		case 'insertPost':
			press2flash_insertPost($xml);
		break;
		
		case 'insertComment':
			press2flash_insertComment($xml);
		break;
		
		case 'getConfig':
			press2flash_getConfig($xml);
		break;
		
		case 'ratePost':
			press2flash_ratePost($xml);
		break;
		
		case 'getPost':
			press2flash_getPost($xml);
		break;
	
		case 'getPosts':
			press2flash_getPosts($xml);
		break;
		
		default:
			createFailMessage("action not allowed");
		break;
			
	}

}


// Simple OK or Fail Result Generating Functions.
function createSuccessMessage($desc)
{
	createMessage("success", $desc);
}

function createFailMessage($desc)
{
	createMessage("failure", $desc);
}

function createMessage($status, $desc)
{
	$output 	= new DomDocument('1.0');	
	$root 		= $output->createElement('press2flash'); 
	$message 	= $output->createElement('message'); 
	$message->setAttribute("status", $status);
	$message->setAttribute("desc", $desc);	
	$output->appendChild($root);	
	$root->appendChild($message);
	$outputString = $output->saveXML();
	print $outputString;
}

	
?>

