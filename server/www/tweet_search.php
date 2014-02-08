<?php
require_once("../lib/twitteroauth.php");
$consumerKey = "";
$consumerSecret = "";
$accessToken = "";
$accessTokenSecret = "";

$twObj = new TwitterOAuth($consumerKey,$consumerSecret,$accessToken,$accessTokenSecret);


$andkey = "ひゃっはー";
$options = array('q'=>$andkey,'count'=>'30');

$json = $twObj->OAuthRequest(
'https://api.twitter.com/1.1/search/tweets.json',
'GET',
$options
);

$jset = json_decode($json, true);
var_dump($jset);
?>

