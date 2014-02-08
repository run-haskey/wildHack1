<?php
require_once("../lib/twitteroauth.php");
$consumerKey = "noPOyyZSAyGZgCCRWDWc5g";
$consumerSecret = "Dk3UXsGGjtsdPaQU142RCXh3yDBjr9xtatESLqDLO1c";
$accessToken = "104060917-Uo1ncenaWL91GZD6FpQHnx9zjsRjorv2yeTeNFMZ";
$accessTokenSecret = "7w1p4YuY8KyfgjHL6HQ2k69jSGfDyt0NqvkfmKUQtauM5";

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

