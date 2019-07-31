




//需要调用的时候直接再     huitu(num,name,zdf);里面传三个参数，num代表股价的数组，name代表股名的数组,zdf代表涨跌幅的数组；顺序不能改变
//涨跌幅的数组直接可以写百分比前面的0~99.99之间的数字，数字用于计算，后面用的时候会添加"%"；如果某个值是负数需要添加"-"
//股价数组、股名数组、涨跌幅的数组之间每一个必须是对应的关系!!；


var list;
var num=[];
var name1=[];
var zdf=[];
var symbo=[];



var bili3=[];
var num3=[];
var name3=[];
var zdf3=[];
var symbo3=[];

//
var a={
    "list":   [
               {
               "num" : "69303424.00",
               "symbol" : "SZ300222",
               "name" : "科大智能",
               "zdf" : "-1.72"
               },
               {
               "num" : "59372096.00",
               "symbol" : "SH600820",
               "name" : "隧道股份",
               "zdf" : "-1.42"
               },
               {
               "num" : "57879496.00",
               "symbol" : "SZ002116",
               "name" : "中国海诚",
               "zdf" : "-7.43"
               },
               {
               "num" : "49196608.00",
               "symbol" : "SH600606",
               "name" : "绿地控股",
               "zdf" : "-0.13"
               },
               {
               "num" : "46507832.00",
               "symbol" : "SH600026",
               "name" : "中远海能",
               "zdf" : "-2.72"
               },
               {
               "num" : "43792128.00",
               "symbol" : "SH600115",
               "name" : "东方航空",
               "zdf" : "-2.41"
               },
               {
               "num" : "43706160.00",
               "symbol" : "SH601866",
               "name" : "中远海发",
               "zdf" : "-4.62"
               },
               {
               "num" : "42725512.00",
               "symbol" : "SZ300059",
               "name" : "东方财富",
               "zdf" : "0.33"
               },
               {
               "num" : "42699568.00",
               "symbol" : "SH601872",
               "name" : "招商轮船",
               "zdf" : "-3.55"
               },
               {
               "num" : "40894128.00",
               "symbol" : "SH600320",
               "name" : "振华重工",
               "zdf" : "-2.69"
               },
               {
               "num" : "38204400.00",
               "symbol" : "SZ300236",
               "name" : "上海新阳",
               "zdf" : "-7.06"
               },
               {
               "num" : "37277808.00",
               "symbol" : "SZ002401",
               "name" : "中海科技",
               "zdf" : "-4.88"
               },
               {
               "num" : "32365900.00",
               "symbol" : "SH600895",
               "name" : "张江高科",
               "zdf" : "-0.63"
               },
               {
               "num" : "30066696.00",
               "symbol" : "SH601788",
               "name" : "光大证券",
               "zdf" : "-0.65"
               },
               {
               "num" : "28605660.00",
               "symbol" : "SH600662",
               "name" : "强生控股",
               "zdf" : "-0.60"
               },
               {
               "num" : "25569748.00",
               "symbol" : "SH600652",
               "name" : "游久游戏",
               "zdf" : "-0.77"
               },
               {
               "num" : "25272056.00",
               "symbol" : "SH600648",
               "name" : "外高桥",
               "zdf" : "-1.85"
               },
               {
               "num" : "25062916.00",
               "symbol" : "SH600641",
               "name" : "万业企业",
               "zdf" : "-0.15"
               },
               {
               "num" : "24946292.00",
               "symbol" : "SH600628",
               "name" : "新世界",
               "zdf" : "-1.91"
               },
               {
               "num" : "22755316.00",
               "symbol" : "SH600503",
               "name" : "华丽家族",
               "zdf" : "-0.39"
               },
               {
               "num" : "21809604.00",
               "symbol" : "SH600643",
               "name" : "爱建集团",
               "zdf" : "0.75"
               },
               {
               "num" : "18808404.00",
               "symbol" : "SH600061",
               "name" : "国投安信",
               "zdf" : "-0.13"
               },
               {
               "num" : "17140352.00",
               "symbol" : "SH601021",
               "name" : "春秋航空",
               "zdf" : "-4.80"
               },
               {
               "num" : "16945232.00",
               "symbol" : "SZ300230",
               "name" : "永利股份",
               "zdf" : "0.52"
               },
               {
               "num" : "14508784.00",
               "symbol" : "SZ300336",
               "name" : "新文化",
               "zdf" : "-0.36"
               },
               {
               "num" : "13966240.00",
               "symbol" : "SH600624",
               "name" : "复旦复华",
               "zdf" : "-1.55"
               },
               {
               "num" : "13926608.00",
               "symbol" : "SH600614",
               "name" : "鹏起科技",
               "zdf" : "2.19"
               },
               {
               "num" : "13476354.00",
               "symbol" : "SH600171",
               "name" : "上海贝岭",
               "zdf" : "-1.07"
               },
               {
               "num" : "13469248.00",
               "symbol" : "SZ300327",
               "name" : "中颖电子",
               "zdf" : "1.14"
               },
               {
               "num" : "13107000.00",
               "symbol" : "SH600618",
               "name" : "氯碱化工",
               "zdf" : "-0.25"
               }
               ]
}


var b={
    "list":   [
               
               
               
               {
               "num" : "25062916.00",
               "symbol" : "SH600641",
               "name" : "万业企业",
               "zdf" : "-0.15"
               },
               {
               "num" : "24946292.00",
               "symbol" : "SH600628",
               "name" : "新世界",
               "zdf" : "-1.91"
               },
               {
               "num" : "22755316.00",
               "symbol" : "SH600503",
               "name" : "华丽家族",
               "zdf" : "-0.39"
               },
               {
               "num" : "21809604.00",
               "symbol" : "SH600643",
               "name" : "爱建集团",
               "zdf" : "0.75"
               },
               {
               "num" : "18808404.00",
               "symbol" : "SH600061",
               "name" : "国投安信",
               "zdf" : "-0.13"
               },
               {
               "num" : "17140352.00",
               "symbol" : "SH601021",
               "name" : "春秋航空",
               "zdf" : "-4.80"
               },
               {
               "num" : "16945232.00",
               "symbol" : "SZ300230",
               "name" : "永利股份",
               "zdf" : "0.52"
               },
               {
               "num" : "14508784.00",
               "symbol" : "SZ300336",
               "name" : "新文化",
               "zdf" : "-0.36"
               },
               {
               "num" : "13966240.00",
               "symbol" : "SH600624",
               "name" : "复旦复华",
               "zdf" : "-1.55"
               },
               {
               "num" : "13926608.00",
               "symbol" : "SH600614",
               "name" : "鹏起科技",
               "zdf" : "2.19"
               }
               ]
}



function cxjs(num){
    
    var he=0
    for(var i=0;i<num.length;i++){
        he+=Math.abs(num[i]);
    }
    for(var i=0;i<num.length;i++){
        num[i]=Math.abs(num[i])/he;
    }
    
    return num;
}

function formatVolume(value)
{
    var str;
		  var B=100000000;
		  var M = 10000;
		  if (Math.abs(value) > B) {
              value /= B;
              str = formatNumber(value, 2);
              str += "亿";
          } else if (Math.abs(value) > M) {
              value /= M;
              str = formatNumber(value, 2);
              str += "万";
          } else {
              str = formatNumber(value, 2);
          }
    
		  return str;
}
function formatNumber(value,n)
{
    if(isNaN(value))
        return "0";
    var s = parseFloat(value + "").toFixed(n) + "";
		  return s;
}


























//根据比例来确定第一个横块中有几个子元素
//       heng(bili,a0,b0,c0,arr,name,zdf,symbo);
function heng(bili3,kuai1,kuai2,kuai3,num3,name3,zdf3,symbo3){
    //heng(bili3,a0,b0,c0,num3,name3,zdf33,symbo33);
    //console.log(num3)
    //alert(symbo3+"，"+bili3+"，"+name3+"，"+zdf3+"，"+symbo3)
    if(bili3[0]>=0.35){
        //横条的宽高
        
        var zdf30=(zdf3[0].split("%")[0])*1;
        //var zdf31=(zdf3[1].split("%")[0])*1;
        //var zdf32=(zdf3[2].split("%")[0])*1;
        
        var color0=yanse(zdf30);
        //var color1=yanse(zdf31);
        //var color2=yanse(zdf32);
        var h1=bili3[0];
        
        var num30=formatVolume(num3[0]);
        
        
        kuai1.style.width="100%";
        kuai1.style.height=h1*100+"%";
        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color0+"; width:100%; height:100%;'>"+name3[0]+"<br/>"+num30+"<br/>"+zdf3[0]+"</a>";
        kuai1.innerHTML=innerhtml;
        num3.splice(0,1);
        name3.splice(0,1);
        symbo3.splice(0,1);
        zdf3.splice(0,1);
        bili3.splice(0,1);
        bili3=cxjs(bili3);
        
        
        
        //纵条的宽高
        
        if(bili3[0]>=0.35){
            var w2=bili3[0];
            var h2=1-h1;
            var zdf300=(zdf3[0].split("%")[0])*1;
            //var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            //var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            var num300=formatVolume(num3[0]);
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:100%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a>";
            kuai2.innerHTML=innerhtml;
            num3.splice(0,1);
            name3.splice(0,1);
            symbo3.splice(0,1);
            zdf3.splice(0,1);
            bili3.splice(0,1);
            bili3=cxjs(bili3);
            
												//第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
            
        }else if(bili3[0]>=0.19){
            var w2=bili3[0]+bili3[1];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1]];
            ttr=cxjs(ttr);
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,2);
            name3.splice(0,2);
            symbo3.splice(0,2);
            zdf3.splice(0,2);
            num3.splice(0,2);
            bili3=cxjs(bili3);
            
												//第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
            
        }else{
            var w2=bili3[0]+bili3[1]+bili3[2];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1],bili3[2]];
            ttr=cxjs(ttr);
            
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            var color02=yanse(zdf302);
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            var num302=formatVolume(num3[2]);
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[2]+" class='tianjiade' style='background:"+color02+"; width:100%; height:"+ttr[2]*100+"%;'>"+name3[2]+"<br/>"+num302+"<br/>"+zdf3[2]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,3);
            num3.splice(0,3);
            symbo3.splice(0,3);
            name3.splice(0,3);
            zdf3.splice(0,3);
            bili3=cxjs(bili3);
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
        }
        
        
        
        
    }else if(bili3[0]>=0.17){
        
        //横条的宽高
        var h1=(bili3[0]+bili3[1]);
        var ktr=[bili3[0],bili3[1]];
        ktr=cxjs(ktr);
        var zdf30=(zdf3[0].split("%")[0])*1;
        var zdf31=(zdf3[1].split("%")[0])*1;
        //var zdf32=(zdf3[2].split("%")[0])*1;
        
        var color0=yanse(zdf30);
        var color1=yanse(zdf31);
        
        var num30=formatVolume(num3[0]);
        var num31=formatVolume(num3[1]);
        
        //var color2=yanse(zdf32);
        kuai1.style.width="100%";
        kuai1.style.height=h1*100+"%";
        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color0+"; width:"+ktr[0]*100+"%; height:100%;'>"+name3[0]+"<br/>"+num30+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color1+"; width:"+ktr[1]*100+"%; height:100%;'>"+name3[1]+"<br/>"+num31+"<br/>"+zdf3[1]+"</a>";
        
        kuai1.innerHTML=innerhtml;
        num3.splice(0,2);
        bili3.splice(0,2);
        name3.splice(0,2);
        symbo3.splice(0,2);
        zdf3.splice(0,2);
        bili3=cxjs(bili3);
        //纵条的宽高
        
        
        if(bili3[0]>=0.35){
            var w2=bili3[0];
            var h2=1-h1;
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            //var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            //var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            var num300=formatVolume(num3[0]);
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:100%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.shift();
            num3.splice(0,1);
            name3.splice(0,1);
            symbo3.splice(0,1);
            zdf3.splice(0,1);
            bili3=cxjs(bili3);
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
        }else if(bili3[0]>=0.2){
            var w2=bili3[0]+bili3[1];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1]];
            ttr=cxjs(ttr);
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            
            
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,2);
            num3.splice(0,2);
            name3.splice(0,2);
            symbo3.splice(0,2);
            zdf3.splice(0,2);
            bili3=cxjs(bili3);
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
        }else{
            var w2=bili3[0]+bili3[1]+bili3[2];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1],bili3[2]]
            ttr=cxjs(ttr);
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            var color02=yanse(zdf302);
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            var num302=formatVolume(num3[2]);
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[2]+" class='tianjiade' style='background:"+color02+"; width:100%; height:"+ttr[2]*100+"%;'>"+name3[2]+"<br/>"+num302+"<br/>"+zdf3[2]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,3);
            num3.splice(0,3);
            name3.splice(0,3);
            symbo3.splice(0,3);
            zdf3.splice(0,3);
            bili3=cxjs(bili3);
            
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
        }
    }else{
        //横条的宽高
        var h1=(bili3[0]+bili3[1]+bili3[2]);
        var ktr=[bili3[0],bili3[1],bili3[2]];
        ktr=cxjs(ktr);
        var num30=formatVolume(num3[0]);
        var num31=formatVolume(num3[1]);
        var num32=formatVolume(num3[2]);
        
        var zdf30=(zdf3[0].split("%")[0])*1;
        var zdf31=(zdf3[1].split("%")[0])*1;
        var zdf32=(zdf3[2].split("%")[0])*1;
        
        var color0=yanse(zdf30);
        var color1=yanse(zdf31);
        var color2=yanse(zdf32);
        kuai1.style.width="100%";
        kuai1.style.height=h1*100+"%";
        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color0+"; width:"+ktr[0]*100+"%; height:100%;'>"+name3[0]+"<br/>"+num30+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color1+"; width:"+ktr[1]*100+"%; height:100%;'>"+name3[1]+"<br/>"+num31+"<br/>"+zdf3[1]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[2]+" class='tianjiade' style='background:"+color2+"; width:"+ktr[2]*100+"%; height:100%;'>"+name3[2]+"<br/>"+num32+"<br/>"+zdf3[2]+"</a>";
        kuai1.innerHTML=innerhtml;
        bili3.splice(0,3);
        num3.splice(0,3);
        name3.splice(0,3);
        symbo3.splice(0,3);
        zdf3.splice(0,3);
        bili3=cxjs(bili3);
        
        //纵条的宽高
        //alert(bili3)
        if(bili3[0]>=0.35){
            var w2=bili3[0];
            var h2=1-h1;
            
            var num300=formatVolume(num3[0]);
            
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            //var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            //var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            
            
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:100%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.shift();
            num3.splice(0,1);
            name3.splice(0,1);
            symbo3.splice(0,1);
            zdf3.splice(0,1);
            bili3=cxjs(bili3);
            
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
            
        }else if(bili3[0]>=0.2){
            var w2=bili3[0]+bili3[1];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1]];
            ttr=cxjs(ttr);
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            //var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            //var color02=yanse(zdf302);
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,2);
            name3.splice(0,2);
            num3.splice(0,2);
            symbo3.splice(0,2);
            zdf3.splice(0,2);
            bili3=cxjs(bili3);
            
            
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
            
            
            
            
        }else{
            var w2=bili3[0]+bili3[1]+bili3[2];
            var h2=1-h1;
            var ttr=[bili3[0],bili3[1],bili3[2]];
            ttr=cxjs(ttr);
            
            var zdf300=(zdf3[0].split("%")[0])*1;
            var zdf301=(zdf3[1].split("%")[0])*1;
            var zdf302=(zdf3[2].split("%")[0])*1;
            
            var color00=yanse(zdf300);
            var color01=yanse(zdf301);
            var color02=yanse(zdf302);
            
            var num300=formatVolume(num3[0]);
            var num301=formatVolume(num3[1]);
            var num302=formatVolume(num3[2]);
            
            kuai2.style.width=w2*100+"%";
            kuai2.style.height=h2*100+"%";
            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color00+"; width:100%; height:"+ttr[0]*100+"%;'>"+name3[0]+"<br/>"+num300+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color01+"; width:100%; height:"+ttr[1]*100+"%;'>"+name3[1]+"<br/>"+num301+"<br/>"+zdf3[1]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[2]+" class='tianjiade' style='background:"+color02+"; width:100%; height:"+ttr[2]*100+"%;'>"+name3[2]+"<br/>"+num302+"<br/>"+zdf3[2]+"</a>";
            kuai2.innerHTML=innerhtml;
            bili3.splice(0,3);
            num3.splice(0,3);
            symbo3.splice(0,3);
            name3.splice(0,3);
            zdf3.splice(0,3);
            //alert(bili3.length)
            bili3=cxjs(bili3);
            
            //第三板块
            var w3=1-w2;
            var h3=1-h1;
            kuai3.style.width=w3*100+"%";
            kuai3.style.height=h3*100+"%";
        }
    }
    
    
    //重新计算所占的比例
    function cxjs(num){
        
        var he=0
        for(var i=0;i<num.length;i++){
            he+=Math.abs(num[i]);
        }
        for(var i=0;i<num.length;i++){
            num[i]=Math.abs(num[i])/he;
        }
        
        return num;
    }
    
    
    
    
    
    //根据涨跌幅来确定颜色
    
    function yanse(zdf){
        
        var color;
        if(zdf>=10){
            color="#fa3336";
        }else if(zdf>=5&&zdf<10){
            color="#fa3336";
        }else if(zdf>=2&&zdf<5){
            color="#c43e49";
        }else if(zdf>0&&zdf<2){
            color="#6c3940";
        }else if(zdf==0){
            color="#424355";
        }
        
        if(zdf<=(-10)){
            color="#214d34";
        }else if(zdf<=(-5)&&zdf>(-10)){
            color="#214d34";
        }else if(zdf<=(-2)&&zdf>(-5)){
            color="#359b51";
        }else if(zdf<0&&zdf>(-2)){
            color="#2ccd59";
        }else if(zdf==0){
            color="#424355";
        }
        //console.log(color)
        return color;
    }
}




















function zhang(bili,name,zdf,symbo){
    
    var length=bili.length;
    bili3=[];
    num3=[];
    name3=[];
    zdf3=[];
    symbo3=[];
    //console.log(bili)
    for(var i=0;i<zdf.length;i++){
        if(zdf[i]>0){
            zdf3[i]="+"+zdf[i]+"%";
        }else{
            zdf3[i]=zdf[i]+"%";
        }
        
        num3[i]=bili[i];
        symbo3[i]=symbo[i];
        name3[i]=name[i];
        //console.log(i)
    }
    
    //console.log(name3)
    
    
    
    
    for(var i=0;i<length;i++){
        bili3.push(num3[i]);
    }
    
    bili3=cxjs(bili3);
    //	console.log(bili);
    //	console.log(name);
    //console.log(zdf);
    //删除掉小于百分之三的数组
    var he=0;
    for(var i=0;i<bili.length;i++){
        he+=Math.abs(bili[i]);
    }
    //alert(he);
    //console.log(bili);
    //console.log(arr);
    
    for(var i=0;i<bili.length;i++){
        if(Math.abs(bili[i])<0.01*he){
            bili3.splice(i,length-i);
            num3.splice(i,length-i);
            name3.splice(i,length-i);
            zdf3.splice(i,length-i);
            symbo3.splice(i,length-i);
            //alert(i);
        }
    }
    bili3=cxjs(bili3)
    
    
    
    
    
    
    var a0=document.getElementsByClassName("a0")[0];
    var b0=document.getElementsByClassName("b0")[0];
    var c0=document.getElementsByClassName("c0")[0];
    var a1=document.getElementsByClassName("a1")[0];
    var b1=document.getElementsByClassName("b1")[0];
    var c1=document.getElementsByClassName("c1")[0];
    var a2=document.getElementsByClassName("a2")[0];
    var b2=document.getElementsByClassName("b2")[0];
    var c2=document.getElementsByClassName("c2")[0];
    var a3=document.getElementsByClassName("a3")[0];
    var b3=document.getElementsByClassName("b3")[0];
    var c3=document.getElementsByClassName("c3")[0];
    var a4=document.getElementsByClassName("a4")[0];
    var b4=document.getElementsByClassName("b4")[0];
    var c4=document.getElementsByClassName("c4")[0];
    var a5=document.getElementsByClassName("a5")[0];
    var b5=document.getElementsByClassName("b5")[0];
    var c5=document.getElementsByClassName("c5")[0];
    
    
    
    
    
    //console.log(bili3);
    if(bili3.length>=1){
        heng(bili3,a0,b0,c0,num3,name3,zdf3,symbo3);
        
        if(bili3.length>=3){
            
            heng(bili3,a1,b1,c1,num3,name3,zdf3,symbo3);
            if(bili3.length>=3){
                
                heng(bili3,a2,b2,c2,num3,name3,zdf3,symbo3);
                if(bili3.length>=3){
                    
                    heng(bili3,a3,b3,c3,num3,name3,zdf3,symbo3);
                    if(bili3.length>=3){
                        
                        heng(bili3,a4,b4,c4,num3,name3,zdf3,symbo3);
                        if(bili3.length>=3){
                            heng(bili3,a5,b5,c5,num3,name3,zdf3,symbo3);
                            
                            if(bili3.length>=3){
                                heng(bili3,a6,b6,c6,num3,name3,zdf3,symbo3);
                                
                                if(bili3.length>=3){
                                    heng(bili3,a7,b7,c7,num3,name3,zdf3,symbo3);
                                }else{
                                    
                                    
                                    if(bili3[1]){
                                        var zdf0=(zdf3[0].split("%")[0])*1;
                                        var zdf1=(zdf3[1].split("%")[0])*1;
                                        var arr0=formatVolume(num3[0]);
                                        var arr1=formatVolume(num3[1]);
                                        
                                        var color000=yanse(zdf0);
                                        var color001=yanse(zdf1);
                                        
                                        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                                        c6.innerHTML=innerhtml;
                                        
                                        
                                        
                                    }else if(bili3[0]){
                                        var zdf0=(zdf3[0].split("%")[0])*1;
                                        var color000=yanse(zdf0);
                                        var arr0=formatVolume(num3[0]);
                                        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                                        c6.innerHTML=innerhtml;
                                        
                                    }
                                }
                            }else{
                                
                                
                                //alert()
                                if(bili3[1]){
                                    var zdf0=(zdf3[0].split("%")[0])*1;
                                    var zdf1=(zdf3[1].split("%")[0])*1;
                                    var arr0=formatVolume(num3[0]);
                                    var arr1=formatVolume(num3[1]);
                                    
                                    var color000=yanse(zdf0);
                                    var color001=yanse(zdf1);
                                    
                                    
                                    var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                                    c5.innerHTML=innerhtml;
                                    
                                }else if(bili3[0]){
                                    
                                    var zdf0=(zdf3[0].split("%")[0])*1;
                                    var color000=yanse(zdf0);
                                    var arr0=formatVolume(num3[0]);
                                    
                                    
                                    var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                                    c5.innerHTML=innerhtml;
                                    
                                }
                                
                            }
                        }else{
                            
                            
                            if(bili3[1]){
                                
                                var zdf0=(zdf3[0].split("%")[0])*1;
                                var zdf1=(zdf3[1].split("%")[0])*1;
                                var arr0=formatVolume(num3[0]);
                                var arr1=formatVolume(num3[1]);
                                
                                var color000=yanse(zdf0);
                                var color001=yanse(zdf1);
                                
                                
                                
                                
                                
                                var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                                c4.innerHTML=innerhtml;
                                
                            }else if(bili3[0]){
                                var zdf0=(zdf3[0].split("%")[0])*1;
                                var color000=yanse(zdf0);
                                var arr0=formatVolume(num3[0]);
                                
                                var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                                c4.innerHTML=innerhtml;
                                
                            }
                        }
                        
                    }else{
                        
                        
                        if(bili3[1]){
                            var zdf0=(zdf3[0].split("%")[0])*1;
                            var zdf1=(zdf3[1].split("%")[0])*1;
                            var arr0=formatVolume(num3[0]);
                            var arr1=formatVolume(num3[1]);
                            
                            var color000=yanse(zdf0);
                            var color001=yanse(zdf1);
                            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                            c3.innerHTML=innerhtml;
                            
                        }else if(bili3[0]){
                            var zdf0=(zdf3[0].split("%")[0])*1;
                            var color000=yanse(zdf0);
                            var arr0=formatVolume(num3[0]);
                            
                            var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                            c3.innerHTML=innerhtml;
                            
                        }
                    }
                    
                }else{
                    
                    
                    if(bili3[1]){
                        var zdf0=(zdf3[0].split("%")[0])*1;
                        var zdf1=(zdf3[1].split("%")[0])*1;
                        var arr0=formatVolume(num3[0]);
                        var arr1=formatVolume(num3[1]);
                        
                        var color000=yanse(zdf0);
                        var color001=yanse(zdf1);
                        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                        c2.innerHTML=innerhtml;
                        
                    }else if(bili3[0]){
                        
                        var zdf0=(zdf3[0].split("%")[0])*1;
                        var color000=yanse(zdf0);
                        var arr0=formatVolume(num3[0]);	
                        
                        var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                        c2.innerHTML=innerhtml;
                        
                    }
                }
                
            }else{
                
                if(bili3[1]){
                    
                    var zdf0=(zdf3[0].split("%")[0])*1;
                    var zdf1=(zdf3[1].split("%")[0])*1;
                    var arr0=formatVolume(num3[0]);
                    var arr1=formatVolume(num3[1]);
                    
                    var color000=yanse(zdf0);
                    var color001=yanse(zdf1);
                    var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                    c1.innerHTML=innerhtml;
                    
                }else if(bili3[0]){
                    
                    var zdf0=(zdf3[0].split("%")[0])*1;
                    var color000=yanse(zdf0);
                    var arr0=formatVolume(num3[0]);	
                    
                    var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                    c1.innerHTML=innerhtml;
                    
                }
            }
            
        }else{
            
            
            if(bili3[1]){		
                
                var zdf0=(zdf3[0].split("%")[0])*1;
                var zdf1=(zdf3[1].split("%")[0])*1;
                var arr0=formatVolume(num3[0]);
                var arr1=formatVolume(num3[1]);
                
                var color000=yanse(zdf0);
                var color001=yanse(zdf1);
                var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a><a onclick=\'click1(this)\' symbol="+symbo3[1]+" class='tianjiade' style='background:"+color001+"; width:100%; height:"+bili3[1]*100+"%;'>"+name3[1]+"<br/>"+arr1+"<br/>"+zdf3[1]+"</a>"
                c0.innerHTML=innerhtml;
                
            }else if(bili3[0]){
                var zdf0=(zdf3[0].split("%")[0])*1;
                var color000=yanse(zdf0);
                var arr0=formatVolume(num3[0]);	
                
                var innerhtml="<a onclick=\'click1(this)\' symbol="+symbo3[0]+" class='tianjiade' style='background:"+color000+"; border:1px solid #000000; box-sizing:border-box; width:100%; height:"+bili3[0]*100+"%;'>"+name3[0]+"<br/>"+arr0+"<br/>"+zdf3[0]+"</a>"
                c0.innerHTML=innerhtml;
                
            }
        }
    }
    //根据涨跌幅来确定颜色
    
    function yanse(zdf){
        var color;
        if(zdf>=10){
            color="#fa3336";
        }else if(zdf>=5){
            color="#fa3336";
        }else if(zdf>=2){
            color="#c43e49";
        }else if(zdf>=0){
            color="#6c3940";
        }else if(zdf==0){
            color="#424355";
        }
        
        if(zdf<=-10){
            color="#214d34";
        }else if(zdf<=-5){
            color="#214d34";
        }else if(zdf<=-2){
            color="#359b51";
        }else if(zdf<=0){
            color="#2ccd59";
        }
        return color;
    }
    
    
    
    
    
    
    
    
    
    
    
}




function huitu(num,name,zdf,symbo){
    
    
    var mc=name;
    //console.log(symbo);
    var dm=symbo;
    
    for(var i=0;i<num.length-1;i++){
        for(var j=i+1;j<num.length;j++){
            //获取第一个值和后一个值比较
            var cur = Math.abs(num[i]);
            var cur1= mc[i];
            var cur2= zdf[i];
            var cur3= dm[i];
            if(cur<Math.abs(num[j])){
                // 因为需要交换值，所以会把后一个值替换，我们要先保存下来
                var index = num[j];
                var index1= mc[j];
                var index2=zdf[j];
                var index3=dm[j];
                // 交换值
                num[j] = cur;
                mc[j]=cur1;
                zdf[j]=cur2;
                dm[j]=cur3;
                
                num[i] = index;
                mc[i] = index1;
                zdf[i] = index2;
                dm[i] = index3;
            }
        }
    }
    
    
    var zhangdiv=document.getElementById("zhang");
    inner="<div class='a0' ></div><div class='b0' ></div><div class='c0' >       <div class='a1' ></div><div class='b1' ></div><div class='c1' >      <div class='a2' ></div><div class='b2' ></div><div class='c2' >          <div class='a3' ></div><div class='b3' ></div><div class='c3' >         <div class='a4' ></div><div class='b4' ></div><div class='c4' >         <div class='a5' ></div><div class='b5' ></div><div class='c5' >     <div class='a6' ></div><div class='b6' ></div><div class='c6' >      <div class='a7' ></div><div class='b7' ></div><div class='c7' ></div>        </div>                  </div>                     </div>                  </div>          </div>        </div>       </div>"
    zhangdiv.innerHTML=inner;
    
    //console.log(mc)
    
    zhang(num,mc,zdf,dm);	
    var lg=$(".tianjiade").length;
    
    for(var i=0;i<lg;i++){
        var w=$(".tianjiade").eq(i).width()/7;
        var h=$(".tianjiade").eq(i).height();
        
        
        if(h>=w*5){
            if(w<=13){				
                w=13;
                var top=(h-(w*3))/2;
                $(".tianjiade").eq(i).css({"line-height":w+"px","padding-top":top});
                $(".tianjiade").eq(i).css({"font-size":15+"px"});
            }else if(w<=20){
                w=20;
                var top=(h-(w*3))/2;
                $(".tianjiade").eq(i).css({"line-height":w+"px","padding-top":top});
                $(".tianjiade").eq(i).css({"font-size":20+"px"});
            }else{			
                var top=(h-(w*3))/2;
                $(".tianjiade").eq(i).css({"line-height":w+"px","padding-top":top});
                $(".tianjiade").eq(i).css({"font-size":w+"px"});
            }
            
        }else{
            var top=h/5;
            $(".tianjiade").eq(i).css({"line-height":top+"px","padding-top":top});
            $(".tianjiade").eq(i).css({"font-size":top+"px"});
        }
        
        
        
        //console.log(colorz[i]);
    }
}
























//function shuaxin(){
//	document.location.reload();	
//}





//function zijin(a){	
//	location=location ;
//	huizhitu(a);
//}

//huizhitu(a);

//setTimeout("huizhitu(a)",3000)



function huizhitu(obj){
    //location=location ;
    //shuzu=[];
    var list=eval("("+obj+")").list;
    //    console.log(list.length);
    
    //document.location.reload();	
    //var list=obj.list;
    //alert(typeof zdf)
    
    
    num=[];
    name1=[];
    zdf=[];
    symbo=[];
    for(var i=0;i<list.length;i++){
        num[i]=list[i].num*1;
        name1[i]=list[i].name;
        //alert(num)
        zdf[i]=list[i].zdf*1;
        symbo[i]=list[i].symbol;
    }
    
    var div=$(".tianjiade");
    if(div){
        $(".tianjiade").remove();
    }
    
    //console.log(symbo)
    
    huitu(num,name1,zdf,symbo);
    
    
    
    
    
    
    
    
    
    
    //根据涨跌幅来确定颜色
    
    function yanse(zdf){
        var color;
        if(zdf>=10){
            color="#fa3336";
        }else if(zdf>=5){
            color="#fa3336";
        }else if(zdf>=2){
            color="#c43e49";
        }else if(zdf>=0){
            color="#6c3940";
        }else if(zdf==0){
            color="#424355";
        }
        
        if(zdf<=-10){
            color="#214d34";
        }else if(zdf<=-5){
            color="#214d34";
        }else if(zdf<=-2){
            color="#359b51";
        }else if(zdf<=0){
            color="#2ccd59";
        }
        return color;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //重新计算所占的比例
    function cxjs(num){
        
        var he=0
        for(var i=0;i<num.length;i++){
            he+=Math.abs(num[i]);
        }
        for(var i=0;i<num.length;i++){
            num[i]=Math.abs(num[i])/he;
        }
        
        return num;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



