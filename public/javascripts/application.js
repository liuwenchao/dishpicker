// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('div.page').live('pagebeforecreate',function(event){
  $('header', this).attr('data-role', "header").attr('data-theme', "b");
  $('footer', this).attr('data-role', "footer").attr('data-theme', "b");
  $('div.content', this).attr('data-role', "content");
  $('a.home', this).attr('data-icon', "home").attr('data-direction', "reverse");
  $('a.back', this).attr('data-icon', "back").attr('data-direction', "reverse");
  $('a.info', this).attr('data-icon', "info");
  $('a.alert', this).attr('data-icon', "alert");
  $('a.inline', this).attr('data-role', "button").attr('data-inline', "true");
  $('ul.listview', this).attr('data-role', "listview").attr('data-inset', "true").attr('data-filter',"true");
  $('ul.listview a:nth-child(2)', this).attr('data-icon', "plus");
  $('div.field', this).attr('data-role', 'fieldcontain');
  $('form', this).has(':file').attr('data-ajax', "false");
});
