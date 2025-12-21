
/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */         
                var a;
                var b;
            function aposid(){
                a = "[";
                b = "[";
                $("#b1 tr").each(function(){
                    a+=$(this).attr("id").substring(3);
                    a+=",";
                });
                $("#b2 tr").each(function(){
                    b+=$(this).attr("id").substring(3);
                    b+=",";
                });
                a=a.substring(0,a.length-1);
                b=b.substring(0,b.length-1);
                a+="]";
                b+="]";
            }


