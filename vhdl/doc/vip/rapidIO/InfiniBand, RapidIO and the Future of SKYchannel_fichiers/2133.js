// Copyright (c) 2001, Legendum LLC. All Rights Reserved.

ss_page = new String(window.location);
ss_mark = ss_page.lastIndexOf('?');
if (ss_mark >= 0) ss_page = ss_page.substring(0, ss_mark);

ss_slash = ss_page.indexOf('/', 8);
if (ss_page.lastIndexOf('.') < ss_page.lastIndexOf('/'))
	ss_page += 'Home+page';

referrer = document.referrer;
if (referrer.substring(0, ss_slash) == ss_page.substring(0, ss_slash))
	referrer = '';

ss_page = ss_page.substring(ss_slash+1, ss_page.length);
ss_html = '<img width="1" height="1" src="http://db2.sitestats.com/db.php';
ss_html += '?site_id=2133&page=' + ss_page + '&referrer=' + referrer;

if (parseInt(navigator.appVersion) >= 4)
{
	var date = new Date();

	ss_html += '&resolution=' + screen.width + 'x' + screen.height;
	ss_html += '&color_bits=' + screen.colorDepth;
	ss_html += '&java=' + navigator.javaEnabled();
	ss_html += '&time=' + date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds();
}

document.write(ss_html + '">');
