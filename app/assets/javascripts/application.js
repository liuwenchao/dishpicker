//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('div.page').live('pagebeforecreate',function(event){
  $('header', this).attr('data-role', "header").attr('data-theme', "b");
  $('footer', this).attr('data-role', "footer").attr('data-theme', "b");
  $('div.content', this).attr('data-role', "content");
  $('div.collapsible-set', this).attr('data-role', "collapsible-set");
  $('div.collapsible', this).attr('data-role', "collapsible").attr('data-content-theme', "b");
  $('div.collapsibled', this).attr('data-collapsed', "true");
  $('div.expanded', this).attr('data-collapsed', "false");
  $('a.home', this).attr('data-icon', "home").attr('data-direction', "reverse");
  $('a.back', this).attr('data-icon', "back").attr('data-direction', "reverse");
  $('a.info', this).attr('data-icon', "info");
  $('a.alert', this).attr('data-icon', "alert");
  $('a.inline', this).attr('data-role', "button").attr('data-inline', "true");
  $('ul.listview', this).attr('data-role', "listview");
  $('ul.inset', this).attr('data-inset', "true");
  $('ul.listview', this).has('li').attr('data-filter',"true").attr('data-filter-placeholder',"Filter...");
  $('ul.listview a:nth-child(2).plus', this).attr('data-icon', "plus");
  $('ul.listview a:nth-child(2).minus', this).attr('data-icon', "minus");
  $('div.field', this).attr('data-role', 'fieldcontain');
  $('form', this).has(':file').attr('data-ajax', "false");
  $('a.b', this).attr('data-theme', 'b');
  $('a.e', this).attr('data-theme', 'e');
});
