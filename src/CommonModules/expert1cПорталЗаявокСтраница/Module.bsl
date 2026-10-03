// expert1c 03.10.2026 Портал заявок для внешних пользователей
// Страница портала (HTML, CSS и JavaScript). В тексте нельзя использовать двойные кавычки.

#Область ПрограммныйИнтерфейс

// Возвращает HTML-страницу портала.
//
// Возвращаемое значение:
//  Строка - HTML-текст страницы
//
Функция ТекстСтраницы() Экспорт
	
	Возврат ЗаголовокИСтили() + ТелоИСкрипт();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЗаголовокИСтили()
	
	Текст =
	"<!DOCTYPE html>
	|<html lang='ru'>
	|<head>
	|<meta charset='utf-8'>
	|<meta name='viewport' content='width=device-width, initial-scale=1'>
	|<title>Заявки в поддержку</title>
	|<style>
	|*{box-sizing:border-box}
	|body{margin:0;font:15px/1.45 system-ui,-apple-system,Segoe UI,Roboto,sans-serif;background:#f3f5f8;color:#1c2430}
	|header{background:#1f4e8c;color:#fff;padding:12px 16px;display:flex;justify-content:space-between;align-items:center;gap:12px}
	|header h1{margin:0;font-size:18px;font-weight:600}
	|main{max-width:860px;margin:20px auto;padding:0 16px}
	|.card{background:#fff;border:1px solid #dde3ea;border-radius:8px;padding:18px;margin-bottom:16px}
	|h2{margin:0 0 12px;font-size:17px}
	|label{display:block;margin:10px 0 4px;font-weight:600;font-size:13px}
	|input,textarea,select{width:100%;padding:9px 10px;border:1px solid #b9c3cf;border-radius:6px;font:inherit;background:#fff;color:inherit}
	|textarea{min-height:130px;resize:vertical}
	|button{padding:9px 16px;border:0;border-radius:6px;background:#1f4e8c;color:#fff;font:inherit;cursor:pointer}
	|button.link{background:none;color:#1f4e8c;padding:0;text-decoration:underline}
	|button.sec{background:#e4e9f0;color:#1c2430}
	|button:disabled{opacity:.6;cursor:default}
	|.row{display:flex;gap:10px;align-items:center;margin-top:14px;flex-wrap:wrap}
	|.tabs{display:flex;gap:8px;margin-bottom:12px}
	|.tabs button{background:#e4e9f0;color:#1c2430}
	|.tabs button.on{background:#1f4e8c;color:#fff}
	|.msg{margin-top:12px;padding:9px 12px;border-radius:6px;background:#fdeaea;color:#8a1c1c}
	|.msg.ok{background:#e6f4ea;color:#1b5e20}
	|table{width:100%;border-collapse:collapse}
	|th,td{text-align:left;padding:8px 6px;border-bottom:1px solid #e6ebf1;font-size:14px}
	|th{font-size:12px;color:#5b6775;text-transform:uppercase}
	|tr.req{cursor:pointer}
	|tr.req:hover{background:#f3f7fc}
	|.st{display:inline-block;padding:2px 9px;border-radius:10px;background:#e4e9f0;font-size:12px;white-space:nowrap}
	|.st.done{background:#e6f4ea;color:#1b5e20}
	|.st.ans{background:#fff4d6;color:#7a5a00}
	|.m{border:1px solid #e0e6ee;border-radius:8px;padding:10px 12px;margin:10px 0;white-space:pre-wrap;word-break:break-word}
	|.m.out{background:#eef4fc;border-color:#cfdff3}
	|.m small{display:block;color:#5b6775;margin-bottom:4px}
	|.pre{white-space:pre-wrap;word-break:break-word}
	|.muted{color:#5b6775}
	|[hidden]{display:none!important}
	|</style>";
	
	Возврат Текст;
	
КонецФункции

Функция ТелоИСкрипт()
	
	Текст =
	"</head>
	|<body>
	|<header><h1>Заявки в поддержку</h1><div><span id='who'></span> <button class='sec' id='btn-out' hidden>Выйти</button></div></header>
	|<main>
	|
	|<section id='v-auth' class='card' hidden>
	|<div class='tabs'><button id='t-login' class='on'>Вход</button><button id='t-reg'>Регистрация</button></div>
	|<form id='f-login'>
	|<label for='l-email'>Электронная почта</label><input id='l-email' type='email' autocomplete='username' required maxlength='100'>
	|<label for='l-pass'>Пароль</label><input id='l-pass' type='password' autocomplete='current-password' required maxlength='100'>
	|<div class='row'><button type='submit'>Войти</button><button type='button' class='link' id='b-forgot'>Забыли пароль?</button></div>
	|</form>
	|<form id='f-reg' hidden>
	|<label for='r-name'>Ваше имя</label><input id='r-name' autocomplete='name' required maxlength='100'>
	|<label for='r-email'>Электронная почта (будет вашим логином)</label><input id='r-email' type='email' autocomplete='email' required maxlength='100'>
	|<div id='r-org-box' hidden><label for='r-org'>Организация</label><select id='r-org'></select></div>
	|<p class='muted'>Мы отправим на этот адрес письмо со ссылкой. По ней вы подтвердите почту и зададите пароль.</p>
	|<div class='row'><button type='submit'>Зарегистрироваться</button></div>
	|</form>
	|<div id='m-auth'></div>
	|</section>
	|
	|<section id='v-pass' class='card' hidden>
	|<h2>Задайте пароль</h2>
	|<form id='f-pass'>
	|<label for='p1'>Пароль (не короче 8 символов)</label><input id='p1' type='password' autocomplete='new-password' required minlength='8' maxlength='100'>
	|<label for='p2'>Повторите пароль</label><input id='p2' type='password' autocomplete='new-password' required minlength='8' maxlength='100'>
	|<div class='row'><button type='submit'>Сохранить и войти</button></div>
	|</form>
	|<div id='m-pass'></div>
	|</section>
	|
	|<section id='v-app' hidden>
	|<div class='card'>
	|<h2>Новая заявка</h2>
	|<form id='f-new'>
	|<label for='n-subj'>Тема</label><input id='n-subj' required maxlength='150'>
	|<label for='n-text'>Описание</label><textarea id='n-text' required maxlength='10000'></textarea>
	|<div class='row'><button type='submit'>Отправить заявку</button></div>
	|</form>
	|<div id='m-new'></div>
	|</div>
	|<div class='card'>
	|<h2>Мои заявки</h2>
	|<div id='list'></div>
	|</div>
	|</section>
	|
	|<section id='v-det' class='card' hidden>
	|<div class='row' style='margin:0 0 10px'><button class='sec' id='b-back'>&larr; К списку</button></div>
	|<h2 id='d-title'></h2>
	|<div class='muted' id='d-meta'></div>
	|<p class='pre' id='d-text'></p>
	|<h2>Переписка</h2>
	|<div id='d-msgs'></div>
	|</section>
	|
	|</main>
	|<script>
	|(function(){
	|var B=location.pathname.replace(/\/?$/,'/');
	|var T=null;
	|try{T=sessionStorage.getItem('pt')}catch(e){}
	|function $(i){return document.getElementById(i)}
	|function el(tag,cls,txt){var e=document.createElement(tag);if(cls)e.className=cls;if(txt!==undefined)e.textContent=txt;return e}
	|function clear(n){while(n.firstChild)n.removeChild(n.firstChild)}
	|function views(name){['v-auth','v-pass','v-app','v-det'].forEach(function(v){$(v).hidden=(v!==name)});$('btn-out').hidden=!T||name==='v-pass'||name==='v-auth'}
	|function msg(id,text,ok){var n=$(id);clear(n);if(text){n.appendChild(el('div','msg'+(ok?' ok':''),text))}}
	|function api(method,path,body){
	| var h={'Content-Type':'application/json'};
	| if(T)h['X-Portal-Token']=T;
	| return fetch(B+'api/'+path,{method:method,headers:h,body:body?JSON.stringify(body):undefined}).then(function(r){
	|  return r.json().catch(function(){return {}}).then(function(d){
	|   if(r.status===401&&T&&path!=='login'){setToken(null);views('v-auth');msg('m-auth','Сессия истекла. Войдите снова.')}
	|   return {ok:r.ok,status:r.status,data:d}})
	| },function(){return {ok:false,status:0,data:{message:'Нет связи с сервером. Повторите позже.'}}})
	|}
	|function setToken(t,name){T=t;try{if(t)sessionStorage.setItem('pt',t);else sessionStorage.removeItem('pt')}catch(e){}$('who').textContent=t&&name?name:''}
	|function busy(form,on){var b=form.querySelector('button[type=submit]');if(b)b.disabled=on}
	|function enter(d){setToken(d.token,d.name);showList()}
	|
	|function showAuth(){views('v-auth')}
	|$('t-login').onclick=function(){$('t-login').className='on';$('t-reg').className='';$('f-login').hidden=false;$('f-reg').hidden=true;msg('m-auth')};
	|$('t-reg').onclick=function(){$('t-reg').className='on';$('t-login').className='';$('f-login').hidden=true;$('f-reg').hidden=false;msg('m-auth')};
	|$('b-forgot').onclick=function(){$('t-reg').click();$('r-email').value=$('l-email').value;msg('m-auth','Введите имя и почту: мы вышлем ссылку для установки нового пароля.',true)};
	|
	|$('f-login').onsubmit=function(e){e.preventDefault();var f=this;busy(f,true);
	| api('POST','login',{email:$('l-email').value,password:$('l-pass').value}).then(function(r){busy(f,false);
	|  if(r.ok){$('l-pass').value='';enter(r.data)}else msg('m-auth',r.data.message||'Не удалось войти.')})};
	|
	|$('f-reg').onsubmit=function(e){e.preventDefault();var f=this;busy(f,true);
	| api('POST','register',{name:$('r-name').value,email:$('r-email').value,organization:$('r-org').value}).then(function(r){busy(f,false);
	|  msg('m-auth',r.data.message||'Не удалось зарегистрироваться.',r.ok)})};
	|
	|$('f-pass').onsubmit=function(e){e.preventDefault();var f=this;
	| if($('p1').value!==$('p2').value){msg('m-pass','Пароли не совпадают.');return}
	| busy(f,true);
	| var tk=new URLSearchParams(location.search).get('token')||'';
	| api('POST','setpassword',{token:tk,password:$('p1').value}).then(function(r){busy(f,false);
	|  if(r.ok){history.replaceState(null,'',B);enter(r.data)}else msg('m-pass',r.data.message||'Не удалось сохранить пароль.')})};
	|
	|$('btn-out').onclick=function(){setToken(null);showAuth()};
	|
	|function statusEl(s,done){var c='st';if(done)c+=' done';else if(s==='Получен ответ')c+=' ans';return el('span',c,s)}
	|
	|function showList(){
	| views('v-app');msg('m-new');
	| var box=$('list');clear(box);box.appendChild(el('p','muted','Загрузка...'));
	| api('GET','requests').then(function(r){clear(box);
	|  if(!r.ok){box.appendChild(el('div','msg',r.data.message||'Не удалось загрузить заявки.'));return}
	|  if(!r.data.requests.length){box.appendChild(el('p','muted','Заявок пока нет.'));return}
	|  var t=el('table'),hd=el('tr');['Номер','Дата','Тема','Статус'].forEach(function(h){hd.appendChild(el('th',null,h))});t.appendChild(hd);
	|  r.data.requests.forEach(function(q){var tr=el('tr','req');
	|   tr.appendChild(el('td',null,q.number));tr.appendChild(el('td',null,q.date));tr.appendChild(el('td',null,q.subject));
	|   var td=el('td');td.appendChild(statusEl(q.status,q.done));tr.appendChild(td);
	|   tr.onclick=function(){showDetail(q.number)};t.appendChild(tr)});
	|  box.appendChild(t)})
	|}
	|
	|$('f-new').onsubmit=function(e){e.preventDefault();var f=this;busy(f,true);
	| api('POST','requests',{subject:$('n-subj').value,text:$('n-text').value}).then(function(r){busy(f,false);
	|  if(r.ok){$('n-subj').value='';$('n-text').value='';showList();msg('m-new','Заявка '+r.data.number+' принята.',true)}
	|  else msg('m-new',r.data.message||'Не удалось отправить заявку.')})};
	|
	|function showDetail(number){
	| views('v-det');
	| $('d-title').textContent='Заявка '+number;$('d-meta').textContent='';$('d-text').textContent='';clear($('d-msgs'));
	| api('GET','requests/'+encodeURIComponent(number)).then(function(r){
	|  if(!r.ok){$('d-text').textContent=r.data.message||'Не удалось загрузить заявку.';return}
	|  var q=r.data;
	|  $('d-title').textContent='Заявка '+q.number+': '+q.subject;
	|  $('d-meta').textContent='Создана '+q.date+' / статус: '+q.status;
	|  $('d-text').textContent=q.text;
	|  var box=$('d-msgs');
	|  if(!q.messages.length){box.appendChild(el('p','muted','Ответов пока нет.'));return}
	|  q.messages.forEach(function(m){var d=el('div','m'+(m.outgoing?' out':''));
	|   d.appendChild(el('small',null,(m.outgoing?'Поддержка':'Вы')+', '+m.date));d.appendChild(document.createTextNode(m.text));box.appendChild(d)})})
	|}
	|$('b-back').onclick=showList;
	|
	|function loadOrgs(){
	| api('GET','organizations').then(function(r){
	|  if(!r.ok||!r.data.organizations)return;
	|  var s=$('r-org');clear(s);
	|  r.data.organizations.forEach(function(o){var op=el('option',null,o.name);op.value=o.id;s.appendChild(op)});
	|  $('r-org-box').hidden=r.data.organizations.length<2})
	|}
	|
	|var q=new URLSearchParams(location.search);
	|if(q.get('token')){setToken(null);views('v-pass')}
	|else if(T){showList()}
	|else{showAuth()}
	|loadOrgs();
	|})();
	|</script>
	|</body>
	|</html>";
	
	Возврат Текст;
	
КонецФункции

#КонецОбласти
