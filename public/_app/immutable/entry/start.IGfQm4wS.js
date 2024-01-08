import{o as Se,t as ke}from"../chunks/scheduler.k-kUyWhY.js";import{S as ct,a as lt,b as ft,H,N as K,r as ne,o as Ae,P as Oe,f as Qe,g as Re,c as de,i as $e,s as Te,d as q,e as F,h as et,j as bt}from"../chunks/singletons.A0r-XR9t.js";new URL("sveltekit-internal://");function Et(e,a){return e==="/"||a==="ignore"?e:a==="never"?e.endsWith("/")?e.slice(0,-1):e:a==="always"&&!e.endsWith("/")?e+"/":e}function St(e){return e.split("%25").map(decodeURI).join("%25")}function kt(e){for(const a in e)e[a]=decodeURIComponent(e[a]);return e}function Ie({href:e}){return e.split("#")[0]}const At=["href","pathname","search","toString","toJSON"];function Ot(e,a,c){const o=new URL(e);Object.defineProperty(o,"searchParams",{value:new Proxy(o.searchParams,{get(u,f){if(f==="get"||f==="getAll"||f==="has")return l=>(c(l),u[f](l));a();const w=Reflect.get(u,f);return typeof w=="function"?w.bind(u):w}}),enumerable:!0,configurable:!0});for(const u of At)Object.defineProperty(o,u,{get(){return a(),e[u]},enumerable:!0,configurable:!0});return Rt(o),o}function Rt(e){Object.defineProperty(e,"hash",{get(){throw new Error("Cannot access event.url.hash. Consider using `$page.url.hash` inside a component instead")}})}const $t="/__data.json",It=".html__data.json";function Pt(e){return e.endsWith(".html")?e.replace(/\.html$/,It):e.replace(/\/$/,"")+$t}function jt(...e){let a=5381;for(const c of e)if(typeof c=="string"){let o=c.length;for(;o;)a=a*33^c.charCodeAt(--o)}else if(ArrayBuffer.isView(c)){const o=new Uint8Array(c.buffer,c.byteOffset,c.byteLength);let u=o.length;for(;u;)a=a*33^o[--u]}else throw new TypeError("value must be a string or TypedArray");return(a>>>0).toString(36)}const ut=window.fetch;window.fetch=(e,a)=>((e instanceof Request?e.method:a?.method||"GET")!=="GET"&&ae.delete(Ce(e)),ut(e,a));const ae=new Map;function xt(e){const a=atob(e),c=new Uint8Array(a.length);for(let o=0;o<a.length;o++)c[o]=a.charCodeAt(o);return c.buffer}function Lt(e,a){const c=Ce(e,a),o=document.querySelector(c);if(o?.textContent){let{body:u,...f}=JSON.parse(o.textContent);const w=o.getAttribute("data-ttl");return w&&ae.set(c,{body:u,init:f,ttl:1e3*Number(w)}),o.getAttribute("data-b64")!==null&&(u=xt(u)),Promise.resolve(new Response(u,f))}return window.fetch(e,a)}function Nt(e,a,c){if(ae.size>0){const o=Ce(e,c),u=ae.get(o);if(u){if(performance.now()<u.ttl&&["default","force-cache","only-if-cached",void 0].includes(c?.cache))return new Response(u.body,u.init);ae.delete(o)}}return window.fetch(a,c)}function Ce(e,a){let o=`script[data-sveltekit-fetched][data-url=${JSON.stringify(e instanceof Request?e.url:e)}]`;if(a?.headers||a?.body){const u=[];a.headers&&u.push([...new Headers(a.headers)].join(",")),a.body&&(typeof a.body=="string"||ArrayBuffer.isView(a.body))&&u.push(a.body),o+=`[data-hash="${jt(...u)}"]`}return o}const Ut=/^(\[)?(\.\.\.)?(\w+)(?:=(\w+))?(\])?$/;function Tt(e){const a=[];return{pattern:e==="/"?/^\/$/:new RegExp(`^${Dt(e).map(o=>{const u=/^\[\.\.\.(\w+)(?:=(\w+))?\]$/.exec(o);if(u)return a.push({name:u[1],matcher:u[2],optional:!1,rest:!0,chained:!0}),"(?:/(.*))?";const f=/^\[\[(\w+)(?:=(\w+))?\]\]$/.exec(o);if(f)return a.push({name:f[1],matcher:f[2],optional:!0,rest:!1,chained:!0}),"(?:/([^/]+))?";if(!o)return;const w=o.split(/\[(.+?)\](?!\])/);return"/"+w.map((g,s)=>{if(s%2){if(g.startsWith("x+"))return Pe(String.fromCharCode(parseInt(g.slice(2),16)));if(g.startsWith("u+"))return Pe(String.fromCharCode(...g.slice(2).split("-").map(O=>parseInt(O,16))));const h=Ut.exec(g);if(!h)throw new Error(`Invalid param: ${g}. Params and matcher names can only have underscores and alphanumeric characters.`);const[,v,I,E,$]=h;return a.push({name:E,matcher:$,optional:!!v,rest:!!I,chained:I?s===1&&w[0]==="":!1}),I?"(.*?)":v?"([^/]*)?":"([^/]+?)"}return Pe(g)}).join("")}).join("")}/?$`),params:a}}function Ct(e){return!/^\([^)]+\)$/.test(e)}function Dt(e){return e.slice(1).split("/").filter(Ct)}function Mt(e,a,c){const o={},u=e.slice(1),f=u.filter(l=>l!==void 0);let w=0;for(let l=0;l<a.length;l+=1){const g=a[l];let s=u[l-w];if(g.chained&&g.rest&&w&&(s=u.slice(l-w,l+1).filter(h=>h).join("/"),w=0),s===void 0){g.rest&&(o[g.name]="");continue}if(!g.matcher||c[g.matcher](s)){o[g.name]=s;const h=a[l+1],v=u[l+1];h&&!h.rest&&h.optional&&v&&g.chained&&(w=0),!h&&!v&&Object.keys(o).length===f.length&&(w=0);continue}if(g.optional&&g.chained){w++;continue}return}if(!w)return o}function Pe(e){return e.normalize().replace(/[[\]]/g,"\\$&").replace(/%/g,"%25").replace(/\//g,"%2[Ff]").replace(/\?/g,"%3[Ff]").replace(/#/g,"%23").replace(/[.*+?^${}()|\\]/g,"\\$&")}function Ft({nodes:e,server_loads:a,dictionary:c,matchers:o}){const u=new Set(a);return Object.entries(c).map(([l,[g,s,h]])=>{const{pattern:v,params:I}=Tt(l),E={id:l,exec:$=>{const O=v.exec($);if(O)return Mt(O,I,o)},errors:[1,...h||[]].map($=>e[$]),layouts:[0,...s||[]].map(w),leaf:f(g)};return E.errors.length=E.layouts.length=Math.max(E.errors.length,E.layouts.length),E});function f(l){const g=l<0;return g&&(l=~l),[g,e[l]]}function w(l){return l===void 0?l:[u.has(l),e[l]]}}function De(e,a=JSON.parse){try{return a(sessionStorage[e])}catch{}}function je(e,a,c=JSON.stringify){const o=c(a);try{sessionStorage[e]=o}catch{}}class xe extends Error{constructor(a,c){super(a),this.name="DevalueError",this.path=c.join("")}}function tt(e){return Object(e)!==e}const Vt=Object.getOwnPropertyNames(Object.prototype).sort().join("\0");function Bt(e){const a=Object.getPrototypeOf(e);return a===Object.prototype||a===null||Object.getOwnPropertyNames(a).sort().join("\0")===Vt}function Ht(e){return Object.prototype.toString.call(e).slice(8,-1)}function qt(e){switch(e){case'"':return'\\"';case"<":return"\\u003C";case"\\":return"\\\\";case`
`:return"\\n";case"\r":return"\\r";case"	":return"\\t";case"\b":return"\\b";case"\f":return"\\f";case"\u2028":return"\\u2028";case"\u2029":return"\\u2029";default:return e<" "?`\\u${e.charCodeAt(0).toString(16).padStart(4,"0")}`:""}}function X(e){let a="",c=0;const o=e.length;for(let u=0;u<o;u+=1){const f=e[u],w=qt(f);w&&(a+=e.slice(c,u)+w,c=u+1)}return`"${c===0?e:a+e.slice(c)}"`}const Me=-1,dt=-2,pt=-3,ht=-4,_t=-5,Fe=-6;function Jt(e,a){return gt(JSON.parse(e),a)}function gt(e,a){if(typeof e=="number")return u(e,!0);if(!Array.isArray(e)||e.length===0)throw new Error("Invalid input");const c=e,o=Array(c.length);function u(f,w=!1){if(f===Me)return;if(f===pt)return NaN;if(f===ht)return 1/0;if(f===_t)return-1/0;if(f===Fe)return-0;if(w)throw new Error("Invalid input");if(f in o)return o[f];const l=c[f];if(!l||typeof l!="object")o[f]=l;else if(Array.isArray(l))if(typeof l[0]=="string"){const g=l[0],s=a?.[g];if(s)return o[f]=s(u(l[1]));switch(g){case"Date":o[f]=new Date(l[1]);break;case"Set":const h=new Set;o[f]=h;for(let E=1;E<l.length;E+=1)h.add(u(l[E]));break;case"Map":const v=new Map;o[f]=v;for(let E=1;E<l.length;E+=2)v.set(u(l[E]),u(l[E+1]));break;case"RegExp":o[f]=new RegExp(l[1],l[2]);break;case"Object":o[f]=Object(l[1]);break;case"BigInt":o[f]=BigInt(l[1]);break;case"null":const I=Object.create(null);o[f]=I;for(let E=1;E<l.length;E+=2)I[l[E]]=u(l[E+1]);break;default:throw new Error(`Unknown type ${g}`)}}else{const g=new Array(l.length);o[f]=g;for(let s=0;s<l.length;s+=1){const h=l[s];h!==dt&&(g[s]=u(h))}}else{const g={};o[f]=g;for(const s in l){const h=l[s];g[s]=u(h)}}return o[f]}return u(0)}function Gt(e,a){const c=[],o=new Map,u=[];for(const s in a)u.push({key:s,fn:a[s]});const f=[];let w=0;function l(s){if(typeof s=="function")throw new xe("Cannot stringify a function",f);if(o.has(s))return o.get(s);if(s===void 0)return Me;if(Number.isNaN(s))return pt;if(s===1/0)return ht;if(s===-1/0)return _t;if(s===0&&1/s<0)return Fe;const h=w++;o.set(s,h);for(const{key:I,fn:E}of u){const $=E(s);if($)return c[h]=`["${I}",${l($)}]`,h}let v="";if(tt(s))v=Le(s);else switch(Ht(s)){case"Number":case"String":case"Boolean":v=`["Object",${Le(s)}]`;break;case"BigInt":v=`["BigInt",${s}]`;break;case"Date":v=`["Date","${s.toISOString()}"]`;break;case"RegExp":const{source:E,flags:$}=s;v=$?`["RegExp",${X(E)},"${$}"]`:`["RegExp",${X(E)}]`;break;case"Array":v="[";for(let O=0;O<s.length;O+=1)O>0&&(v+=","),O in s?(f.push(`[${O}]`),v+=l(s[O]),f.pop()):v+=dt;v+="]";break;case"Set":v='["Set"';for(const O of s)v+=`,${l(O)}`;v+="]";break;case"Map":v='["Map"';for(const[O,D]of s)f.push(`.get(${tt(O)?Le(O):"..."})`),v+=`,${l(O)},${l(D)}`;v+="]";break;default:if(!Bt(s))throw new xe("Cannot stringify arbitrary non-POJOs",f);if(Object.getOwnPropertySymbols(s).length>0)throw new xe("Cannot stringify POJOs with symbolic keys",f);if(Object.getPrototypeOf(s)===null){v='["null"';for(const O in s)f.push(`.${O}`),v+=`,${X(O)},${l(s[O])}`,f.pop();v+="]"}else{v="{";let O=!1;for(const D in s)O&&(v+=","),O=!0,f.push(`.${D}`),v+=`${X(D)}:${l(s[D])}`,f.pop();v+="}"}}return c[h]=v,h}const g=l(e);return g<0?`${g}`:`[${c.join(",")}]`}function Le(e){const a=typeof e;return a==="string"?X(e):e instanceof String?X(e.toString()):e===void 0?Me.toString():e===0&&1/e<0?Fe.toString():a==="bigint"?`["BigInt","${e}"]`:String(e)}const mt=new Set(["load","prerender","csr","ssr","trailingSlash","config"]);[...mt];const Kt=new Set([...mt]);[...Kt];function Yt(e){return e.filter(a=>a!=null)}class _e{constructor(a,c){this.status=a,typeof c=="string"?this.body={message:c}:c?this.body=c:this.body={message:`Error: ${a}`}}toString(){return JSON.stringify(this.body)}}class nt{constructor(a,c){this.status=a,this.location=c}}class Ve extends Error{constructor(a,c,o){super(o),this.status=a,this.text=c}}const zt="x-sveltekit-invalidated",Wt="x-sveltekit-trailing-slash";function pe(e){return e instanceof _e||e instanceof Ve?e.status:500}function Xt(e){return e instanceof Ve?e.text:"Internal Error"}const Y=De(ct)??{},re=De(lt,Jt)??{},oe=De(ft)??{},rt=history.pushState,he=history.replaceState;function Ne(e){Y[e]=Te()}function at(e,a){let c=e+1;for(;Y[c];)delete Y[c],c+=1;for(c=a+1;oe[c];)delete oe[c],c+=1}function W(e){return location.href=e.href,new Promise(()=>{})}function ot(){}function Zt(e,a){const c=Ft(e),o=e.nodes[0],u=e.nodes[1];o(),u();const f=document.documentElement,w=[],l=[];let g=null;const s={before_navigate:[],on_navigate:[],after_navigate:[]};let h={branch:[],error:null,url:null},v=!1,I=!1,E=!0,$=!1,O=!1,D=!1,Z=!1,se=!1,V,L=history.state?.[H],M=history.state?.[K];L||(L=M=Date.now(),he.call(history,{...history.state,[H]:L,[K]:M},"",location.href));const ge=Y[L];ge&&(history.scrollRestoration="manual",scrollTo(ge.x,ge.y));let j,z,me;async function Be(){if(await(me||=Promise.resolve()),!me)return;me=null;const n=ee(h.url,!0);g=null;const t=z={},r=n&&await ve(n);t===z&&(r&&(r.type==="redirect"?await ie(new URL(r.location,h.url).href,{},1,t):(r.props.page!==void 0&&(j=r.props.page),V.$set(r.props))),w.length=0)}function He(n){l.some(t=>t?.snapshot)&&(oe[n]=l.map(t=>t?.snapshot?.capture()))}function qe(n){oe[n]?.forEach((t,r)=>{l[r]?.snapshot?.restore(t)})}function Je(){Ne(L),je(ct,Y),He(M),je(ft,oe),je(lt,re,Gt)}async function ie(n,t,r,i){return fe({type:"goto",url:ne(n),keepfocus:t.keepFocus,noscroll:t.noScroll,replace_state:t.replaceState,redirect_count:r,state:t.state,nav_token:i,accept:()=>{t.invalidateAll&&(se=!0)}})}async function Ge(n){return g={id:n.id,promise:ve(n).then(t=>(t.type==="loaded"&&t.state.error&&(g=null),t))},g.promise}async function ce(n){const t=c.find(r=>r.exec(We(n)));t&&await Promise.all([...t.layouts,t.leaf].map(r=>r?.[1]()))}function Ke(n){h=n.state;const t=document.querySelector("style[data-sveltekit]");t&&t.remove(),j=n.props.page,V=new e.root({target:a,props:{...n.props,stores:q,components:l},hydrate:!0}),qe(M);const r={from:null,to:{params:h.params,route:{id:h.route?.id??null},url:new URL(location.href)},willUnload:!1,type:"enter",complete:Promise.resolve()};s.after_navigate.forEach(i=>i(r)),I=!0}async function Q({url:n,params:t,branch:r,status:i,error:d,route:p,form:_}){let y="never";for(const A of r)A?.slash!==void 0&&(y=A.slash);n.pathname=Et(n.pathname,y),n.search=n.search;const S={type:"loaded",state:{url:n,params:t,branch:r,error:d,route:p},props:{constructors:Yt(r).map(A=>A.node.component),page:j}};_!==void 0&&(S.props.form=_);let b={},N=!j,U=0;for(let A=0;A<Math.max(r.length,h.branch.length);A+=1){const x=r[A],R=h.branch[A];x?.data!==R?.data&&(N=!0),x&&(b={...b,...x.data},N&&(S.props[`data_${U}`]=b),U+=1)}return(!h.url||n.href!==h.url.href||h.error!==d||_!==void 0&&_!==j.form||N)&&(S.props.page={error:d,params:t,route:{id:p?.id??null},state:{},status:i,url:new URL(n),form:_??null,data:N?b:j.data}),S}async function ye({loader:n,parent:t,url:r,params:i,route:d,server_data_node:p}){let _=null,y=!0;const S={dependencies:new Set,params:new Set,parent:!1,route:!1,url:!1,search_params:new Set},b=await n();if(b.universal?.load){let N=function(...m){for(const A of m){const{href:x}=new URL(A,r);S.dependencies.add(x)}};const U={route:new Proxy(d,{get:(m,A)=>(y&&(S.route=!0),m[A])}),params:new Proxy(i,{get:(m,A)=>(y&&S.params.add(A),m[A])}),data:p?.data??null,url:Ot(r,()=>{y&&(S.url=!0)},m=>{y&&S.search_params.add(m)}),async fetch(m,A){let x;m instanceof Request?(x=m.url,A={body:m.method==="GET"||m.method==="HEAD"?void 0:await m.blob(),cache:m.cache,credentials:m.credentials,headers:m.headers,integrity:m.integrity,keepalive:m.keepalive,method:m.method,mode:m.mode,redirect:m.redirect,referrer:m.referrer,referrerPolicy:m.referrerPolicy,signal:m.signal,...A}):x=m;const R=new URL(x,r);return y&&N(R.href),R.origin===r.origin&&(x=R.href.slice(r.origin.length)),I?Nt(x,R.href,A):Lt(x,A)},setHeaders:()=>{},depends:N,parent(){return y&&(S.parent=!0),t()},untrack(m){y=!1;try{return m()}finally{y=!0}}};_=await b.universal.load.call(null,U)??null}return{node:b,loader:n,server:p,universal:b.universal?.load?{type:"data",data:_,uses:S}:null,data:_??p?.data??null,slash:F&&(r.pathname===F||r.pathname===F+"/")?"always":b.universal?.trailingSlash??p?.slash}}function Ye(n,t,r,i,d,p){if(se)return!0;if(!d)return!1;if(d.parent&&n||d.route&&t||d.url&&r)return!0;for(const _ of d.search_params)if(i.has(_))return!0;for(const _ of d.params)if(p[_]!==h.params[_])return!0;for(const _ of d.dependencies)if(w.some(y=>y(new URL(_))))return!0;return!1}function we(n,t){return n?.type==="data"?n:n?.type==="skip"?t??null:null}function wt(n,t){if(!n)return new Set(t.searchParams.keys());const r=new Set([...n.searchParams.keys(),...t.searchParams.keys()]);for(const i of r){const d=n.searchParams.getAll(i),p=t.searchParams.getAll(i);d.every(_=>p.includes(_))&&p.every(_=>d.includes(_))&&r.delete(i)}return r}async function ve({id:n,invalidating:t,url:r,params:i,route:d}){if(g?.id===n)return g.promise;const{errors:p,layouts:_,leaf:y}=d,S=[..._,y];p.forEach(k=>k?.().catch(()=>{})),S.forEach(k=>k?.[1]().catch(()=>{}));let b=null;const N=h.url?n!==h.url.pathname+h.url.search:!1,U=h.route?d.id!==h.route.id:!1,m=wt(h.url,r);let A=!1;const x=S.map((k,P)=>{const T=h.branch[P],C=!!k?.[0]&&(T?.loader!==k[1]||Ye(A,U,N,m,T.server?.uses,i));return C&&(A=!0),C});if(x.some(Boolean)){try{b=await st(r,x)}catch(k){return le({status:pe(k),error:await te(k,{url:r,params:i,route:{id:d.id}}),url:r,route:d})}if(b.type==="redirect")return b}const R=b?.nodes;let B=!1;const J=S.map(async(k,P)=>{if(!k)return;const T=h.branch[P],C=R?.[P];if((!C||C.type==="skip")&&k[1]===T?.loader&&!Ye(B,U,N,m,T.universal?.uses,i))return T;if(B=!0,C?.type==="error")throw C;return ye({loader:k[1],url:r,params:i,route:d,parent:async()=>{const be={};for(let Ee=0;Ee<P;Ee+=1)Object.assign(be,(await J[Ee])?.data);return be},server_data_node:we(C===void 0&&k[0]?{type:"skip"}:C??null,k[0]?T?.server:void 0)})});for(const k of J)k.catch(()=>{});const G=[];for(let k=0;k<S.length;k+=1)if(S[k])try{G.push(await J[k])}catch(P){if(P instanceof nt)return{type:"redirect",location:P.location};let T=pe(P),C;if(R?.includes(P))T=P.status??T,C=P.error;else if(P instanceof _e)C=P.body;else{if(await q.updated.check())return await W(r);C=await te(P,{params:i,url:r,route:{id:d.id}})}const ue=await ze(k,G,p);return ue?await Q({url:r,params:i,branch:G.slice(0,ue.idx).concat(ue.node),status:T,error:C,route:d}):await Ze(r,{id:d.id},C,T)}else G.push(void 0);return await Q({url:r,params:i,branch:G,status:200,error:null,route:d,form:t?void 0:null})}async function ze(n,t,r){for(;n--;)if(r[n]){let i=n;for(;!t[i];)i-=1;try{return{idx:i+1,node:{node:await r[n](),loader:r[n],data:{},server:null,universal:null}}}catch{continue}}}async function le({status:n,error:t,url:r,route:i}){const d={};let p=null;if(e.server_loads[0]===0)try{const b=await st(r,[!0]);if(b.type!=="data"||b.nodes[0]&&b.nodes[0].type!=="data")throw 0;p=b.nodes[0]??null}catch{(r.origin!==Ae||r.pathname!==location.pathname||v)&&await W(r)}const y=await ye({loader:o,url:r,params:d,route:i,parent:()=>Promise.resolve({}),server_data_node:we(p)}),S={node:await u(),loader:u,universal:null,server:null,data:null};return await Q({url:r,params:d,branch:[y,S],status:n,error:t,route:null})}function ee(n,t){if($e(n,F))return;const r=We(n.pathname);for(const i of c){const d=i.exec(r);if(d)return{id:n.pathname+n.search,invalidating:t,route:i,params:kt(d),url:n}}}function We(n){return St(n.slice(F.length)||"/")}function Xe({url:n,type:t,intent:r,delta:i}){let d=!1;const p=it(h,r,n,t);i!==void 0&&(p.navigation.delta=i);const _={...p.navigation,cancel:()=>{d=!0,p.reject(new Error("navigation was cancelled"))}};return O||s.before_navigate.forEach(y=>y(_)),d?null:p}async function fe({type:n,url:t,popped:r,keepfocus:i,noscroll:d,replace_state:p,state:_={},redirect_count:y=0,nav_token:S={},accept:b=ot,block:N=ot}){const U=ee(t,!1),m=Xe({url:t,type:n,delta:r?.delta,intent:U});if(!m){N();return}const A=L,x=M;b(),O=!0,I&&q.navigating.set(m.navigation),z=S;let R=U&&await ve(U);if(!R){if($e(t,F))return await W(t);R=await Ze(t,{id:null},await te(new Ve(404,"Not Found",`Not found: ${t.pathname}`),{url:t,params:{},route:{id:null}}),404)}if(t=U?.url||t,z!==S)return m.reject(new Error("navigation was aborted")),!1;if(R.type==="redirect")if(y>=20)R=await le({status:500,error:await te(new Error("Redirect loop"),{url:t,params:{},route:{id:null}}),url:t,route:{id:null}});else return ie(new URL(R.location,t).href,{},y+1,S),!1;else R.props.page.status>=400&&await q.updated.check()&&await W(t);if(w.length=0,se=!1,$=!0,Ne(A),He(x),R.props.page.url.pathname!==t.pathname&&(t.pathname=R.props.page.url.pathname),_=r?r.state:_,!r){const k=p?0:1,P={[H]:L+=k,[K]:M+=k};(p?he:rt).call(history,P,"",t),p||at(L,M)}if(re[L]=_,g=null,R.props.page.state=_,I){h=R.state,R.props.page&&(R.props.page.url=t);const k=(await Promise.all(s.on_navigate.map(P=>P(m.navigation)))).filter(P=>typeof P=="function");if(k.length>0){let P=function(){s.after_navigate=s.after_navigate.filter(T=>!k.includes(T))};k.push(P),s.after_navigate.push(...k)}V.$set(R.props),Z=!0}else Ke(R);const{activeElement:B}=document;await ke();const J=r?r.scroll:d?Te():null;if(E){const k=t.hash&&document.getElementById(decodeURIComponent(t.hash.slice(1)));J?scrollTo(J.x,J.y):k?k.scrollIntoView():scrollTo(0,0)}const G=document.activeElement!==B&&document.activeElement!==document.body;!i&&!G&&Ue(),E=!0,R.props.page&&(j=R.props.page),O=!1,n==="popstate"&&qe(M),m.fulfil(void 0),s.after_navigate.forEach(k=>k(m.navigation)),q.navigating.set(null),$=!1}async function Ze(n,t,r,i){return n.origin===Ae&&n.pathname===location.pathname&&!v?await le({status:i,error:r,url:n,route:t}):await W(n)}function vt(){let n;f.addEventListener("mousemove",p=>{const _=p.target;clearTimeout(n),n=setTimeout(()=>{i(_,2)},20)});function t(p){i(p.composedPath()[0],1)}f.addEventListener("mousedown",t),f.addEventListener("touchstart",t,{passive:!0});const r=new IntersectionObserver(p=>{for(const _ of p)_.isIntersecting&&(ce(_.target.href),r.unobserve(_.target))},{threshold:0});function i(p,_){const y=Qe(p,f);if(!y)return;const{url:S,external:b,download:N}=Re(y,F);if(b||N)return;const U=de(y);if(!U.reload)if(_<=U.preload_data){const m=ee(S,!1);m&&Ge(m)}else _<=U.preload_code&&ce(S.pathname)}function d(){r.disconnect();for(const p of f.querySelectorAll("a")){const{url:_,external:y,download:S}=Re(p,F);if(y||S)continue;const b=de(p);b.reload||(b.preload_code===et.viewport&&r.observe(p),b.preload_code===et.eager&&ce(_.pathname))}}s.after_navigate.push(d),d()}function te(n,t){if(n instanceof _e)return n.body;const r=pe(n),i=Xt(n);return e.hooks.handleError({error:n,event:t,status:r,message:i})??{message:i}}return{after_navigate:n=>{Se(()=>(s.after_navigate.push(n),()=>{const t=s.after_navigate.indexOf(n);s.after_navigate.splice(t,1)}))},before_navigate:n=>{Se(()=>(s.before_navigate.push(n),()=>{const t=s.before_navigate.indexOf(n);s.before_navigate.splice(t,1)}))},on_navigate:n=>{Se(()=>(s.on_navigate.push(n),()=>{const t=s.on_navigate.indexOf(n);s.on_navigate.splice(t,1)}))},disable_scroll_handling:()=>{($||!I)&&(E=!1)},goto:(n,t={})=>(n=ne(n),n.origin!==Ae?Promise.reject(new Error("goto: invalid URL")):ie(n,t,0)),invalidate:n=>{if(typeof n=="function")w.push(n);else{const{href:t}=new URL(n,location.href);w.push(r=>r.href===t)}return Be()},invalidate_all:()=>(se=!0,Be()),preload_data:async n=>{const t=ne(n),r=ee(t,!1);if(!r)throw new Error(`Attempted to preload a URL that does not belong to this app: ${t}`);const i=await Ge(r);if(i.type==="redirect")return{type:i.type,location:i.location};const{status:d,data:p}=i.props.page??j;return{type:i.type,status:d,data:p}},preload_code:n=>ce(n),push_state:(n,t)=>{const r={[H]:L+=1,[K]:M,[Oe]:j.url.href};rt.call(history,r,"",ne(n)),j={...j,state:t},V.$set({page:j}),re[L]=t,at(L,M)},replace_state:(n,t)=>{const r={[H]:L,[K]:M,[Oe]:j.url.href};he.call(history,r,"",ne(n)),j={...j,state:t},V.$set({page:j}),re[L]=t},apply_action:async n=>{if(n.type==="error"){const t=new URL(location.href),{branch:r,route:i}=h;if(!i)return;const d=await ze(h.branch.length,r,i.errors);if(d){const p=await Q({url:t,params:h.params,branch:r.slice(0,d.idx).concat(d.node),status:n.status??500,error:n.error,route:i});h=p.state,V.$set(p.props),ke().then(Ue)}}else n.type==="redirect"?ie(n.location,{invalidateAll:!0},0):(V.$set({form:null,page:{...j,form:n.data,status:n.status}}),await ke(),V.$set({form:n.data}),n.type==="success"&&Ue())},_start_router:()=>{history.scrollRestoration="manual",addEventListener("beforeunload",t=>{let r=!1;if(Je(),!O){const i=it(h,void 0,null,"leave"),d={...i.navigation,cancel:()=>{r=!0,i.reject(new Error("navigation was cancelled"))}};s.before_navigate.forEach(p=>p(d))}r?(t.preventDefault(),t.returnValue=""):history.scrollRestoration="auto"}),addEventListener("visibilitychange",()=>{document.visibilityState==="hidden"&&Je()}),navigator.connection?.saveData||vt(),f.addEventListener("click",t=>{if(t.button||t.which!==1||t.metaKey||t.ctrlKey||t.shiftKey||t.altKey||t.defaultPrevented)return;const r=Qe(t.composedPath()[0],f);if(!r)return;const{url:i,external:d,target:p,download:_}=Re(r,F);if(!i)return;if(p==="_parent"||p==="_top"){if(window.parent!==window)return}else if(p&&p!=="_self")return;const y=de(r);if(!(r instanceof SVGAElement)&&i.protocol!==location.protocol&&!(i.protocol==="https:"||i.protocol==="http:")||_)return;if(d||y.reload){Xe({url:i,type:"link"})?O=!0:t.preventDefault();return}const[b,N]=i.href.split("#");if(N!==void 0&&b===Ie(location)){if(h.url.hash===i.hash){t.preventDefault(),r.ownerDocument.getElementById(N)?.scrollIntoView();return}if(D=!0,Ne(L),n(i),!y.replace_state)return;D=!1}t.preventDefault(),fe({type:"link",url:i,keepfocus:y.keepfocus,noscroll:y.noscroll,replace_state:y.replace_state??i.href===location.href})}),f.addEventListener("submit",t=>{if(t.defaultPrevented)return;const r=HTMLFormElement.prototype.cloneNode.call(t.target),i=t.submitter;if((i?.formMethod||r.method)!=="get")return;const p=new URL(i?.hasAttribute("formaction")&&i?.formAction||r.action);if($e(p,F))return;const _=t.target,y=de(_);if(y.reload)return;t.preventDefault(),t.stopPropagation();const S=new FormData(_),b=i?.getAttribute("name");b&&S.append(b,i?.getAttribute("value")??""),p.search=new URLSearchParams(S).toString(),fe({type:"form",url:p,keepfocus:y.keepfocus,noscroll:y.noscroll,replace_state:y.replace_state??p.href===location.href})}),addEventListener("popstate",async t=>{if(t.state?.[H]){const r=t.state[H];if(z={},r===L)return;const i=Y[r],d=re[r]??{},p=new URL(t.state[Oe]??location.href),_=t.state[K],y=Ie(location)===Ie(h.url);if(_===M&&(Z||y)){n(p),Y[L]=Te(),i&&scrollTo(i.x,i.y),d!==j.state&&(j={...j,state:d},V.$set({page:j})),L=r;return}const b=r-L;await fe({type:"popstate",url:p,popped:{state:d,scroll:i,delta:b},accept:()=>{L=r,M=_},block:()=>{history.go(-b)},nav_token:z})}else if(!D){const r=new URL(location.href);n(r)}}),addEventListener("hashchange",()=>{D&&(D=!1,he.call(history,{...history.state,[H]:++L,[K]:M},"",location.href))});for(const t of document.querySelectorAll("link"))t.rel==="icon"&&(t.href=t.href);addEventListener("pageshow",t=>{t.persisted&&q.navigating.set(null)});function n(t){h.url=t,q.page.set({...j,url:t}),q.page.notify()}},_hydrate:async({status:n=200,error:t,node_ids:r,params:i,route:d,data:p,form:_})=>{v=!0;const y=new URL(location.href);({params:i={},route:d={id:null}}=ee(y,!1)||{});let S;try{const b=r.map(async(m,A)=>{const x=p[A];return x?.uses&&(x.uses=yt(x.uses)),ye({loader:e.nodes[m],url:y,params:i,route:d,parent:async()=>{const R={};for(let B=0;B<A;B+=1)Object.assign(R,(await b[B]).data);return R},server_data_node:we(x)})}),N=await Promise.all(b),U=c.find(({id:m})=>m===d.id);if(U){const m=U.layouts;for(let A=0;A<m.length;A++)m[A]||N.splice(A,0,void 0)}S=await Q({url:y,params:i,branch:N,status:n,error:t,form:_,route:U??null})}catch(b){if(b instanceof nt){await W(new URL(b.location,location.href));return}S=await le({status:pe(b),error:await te(b,{url:y,params:i,route:d}),url:y,route:d})}S.props.page&&(S.props.page.state={}),Ke(S)}}}async function st(e,a){const c=new URL(e);c.pathname=Pt(e.pathname),e.pathname.endsWith("/")&&c.searchParams.append(Wt,"1"),c.searchParams.append(zt,a.map(u=>u?"1":"0").join(""));const o=await ut(c.href);if(!o.ok){let u;throw o.headers.get("content-type")?.includes("application/json")?u=await o.json():o.status===404?u="Not Found":o.status===500&&(u="Internal Error"),new _e(o.status,u)}return new Promise(async u=>{const f=new Map,w=o.body.getReader(),l=new TextDecoder;function g(h){return gt(h,{Promise:v=>new Promise((I,E)=>{f.set(v,{fulfil:I,reject:E})})})}let s="";for(;;){const{done:h,value:v}=await w.read();if(h&&!s)break;for(s+=!v&&s?`
`:l.decode(v);;){const I=s.indexOf(`
`);if(I===-1)break;const E=JSON.parse(s.slice(0,I));if(s=s.slice(I+1),E.type==="redirect")return u(E);if(E.type==="data")E.nodes?.forEach($=>{$?.type==="data"&&($.uses=yt($.uses),$.data=g($.data))}),u(E);else if(E.type==="chunk"){const{id:$,data:O,error:D}=E,Z=f.get($);f.delete($),D?Z.reject(g(D)):Z.fulfil(g(O))}}}})}function yt(e){return{dependencies:new Set(e?.dependencies??[]),params:new Set(e?.params??[]),parent:!!e?.parent,route:!!e?.route,url:!!e?.url,search_params:new Set(e?.search_params??[])}}function Ue(){const e=document.querySelector("[autofocus]");if(e)e.focus();else{const a=document.body,c=a.getAttribute("tabindex");a.tabIndex=-1,a.focus({preventScroll:!0,focusVisible:!1}),c!==null?a.setAttribute("tabindex",c):a.removeAttribute("tabindex");const o=getSelection();if(o&&o.type!=="None"){const u=[];for(let f=0;f<o.rangeCount;f+=1)u.push(o.getRangeAt(f));setTimeout(()=>{if(o.rangeCount===u.length){for(let f=0;f<o.rangeCount;f+=1){const w=u[f],l=o.getRangeAt(f);if(w.commonAncestorContainer!==l.commonAncestorContainer||w.startContainer!==l.startContainer||w.endContainer!==l.endContainer||w.startOffset!==l.startOffset||w.endOffset!==l.endOffset)return}o.removeAllRanges()}})}}}function it(e,a,c,o){let u,f;const w=new Promise((g,s)=>{u=g,f=s});return w.catch(()=>{}),{navigation:{from:{params:e.params,route:{id:e.route?.id??null},url:e.url},to:c&&{params:a?.params??null,route:{id:a?.route?.id??null},url:c},willUnload:!a,type:o,complete:w},fulfil:u,reject:f}}async function tn(e,a,c){const o=Zt(e,a);bt({client:o}),c?await o._hydrate(c):o.goto(location.href,{replaceState:!0}),o._start_router()}export{tn as start};
