<%--  
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
 --%>
 
  <%@page import="com.dashboard.vehicle.availabilitylist.ClsavailabilitylistDAO" %>
<% ClsavailabilitylistDAO cad=new ClsavailabilitylistDAO();%>
 
 <%@page import="java.util.*" %>
 <%@page import="java.text.SimpleDateFormat" %>
  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%

	String chk = request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");




String a1="";String a2="";String a3="";String a4="";String a5="";String a6="";String a7="";String a8="";
String a9="";String a10="";String a11="";String a12="";String a13="";String a14="";String a15="";
String a16="";String a17="";String a18="";String a19="";String a20="";String a21="";String a22="";String a23="";
String a24="";String a25="";String a26="";String a27="";String a28="";String a29="";String a30="";

for(int i=0;i<=29;i++)
{
Calendar now = Calendar.getInstance();

now.add(Calendar.DATE, i);

 if(i==0){ a1=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==1){ a2=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==2){ a3=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==3){ a4=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==4){ a5=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==5){ a6=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==6){ a7=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==7){ a8=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==8){ a9=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==9){ a10=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==10){ a11=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==11){ a12=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==12){ a13=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==13){ a14=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==14){ a15=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}

if(i==15){ a16=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==16){ a17=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==17){ a18=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==18){ a19=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==19){ a20=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==20){ a21=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==21){ a22=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==22){ a23=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==23){ a24=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==24){ a25=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==25){ a26=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==26){ a27=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==27){ a28=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==28){ a29=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}
if(i==29){ a30=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1);}


/* a1=""+now.get(Calendar.DATE)+"-"+(now.get(Calendar.MONTH) + 1)+"-"+now.get(Calendar.YEAR); */
}
%>

 <style>

  .yellowClass
        {
        
       
       background-color: #eedd82; 
        /*   background-color: #eedd82;  */
        }
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .redClass
        {
            background-color: #ff6347; 
         /*  background-color: #FFEBEB; */
        }
 </style>

 <script type="text/javascript">




 var a1='<%=a1%>'; 
var a2='<%=a2%>';
var a3='<%=a3%>';
var a4='<%=a4%>';
var a5='<%=a5%>';
var a6='<%=a6%>';
var a7='<%=a7%>';
var a8='<%=a8%>';
var a9='<%=a9%>';
var a10='<%=a10%>';
var a11='<%=a11%>';
var a12='<%=a12%>';
var a13='<%=a13%>';
 var a14='<%=a14%>';
 var a15='<%=a15%>';
 
 
 var a16='<%=a16%>'; 
 var a17='<%=a17%>';
 var a18='<%=a18%>';
 var a19='<%=a19%>';
 var a20='<%=a20%>';
 var a21='<%=a21%>';
 var a22='<%=a22%>';
 var a23='<%=a23%>';
 var a24='<%=a24%>';
 var a25='<%=a25%>';
 var a26='<%=a26%>';
 var a27='<%=a27%>';
 var a28='<%=a28%>';
 var a29='<%=a29%>';
  var a30='<%=a30%>';
  var vehdata;
  
  var temp='<%=chk%>';
  
  if(temp!='NA'){
  
  vehdata='<%=cad.vehSearch(barchval)%>'; 
  }
  else
	  {
	  vehdata;
	  }
        $(document).ready(function () { 	
        	
        	  	 
        	        
        	    
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                          	{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'days', type: 'String'  },
     						
     		
     					  	{name : 'color', type: 'String'  },
     						{name : 'clrid', type: 'String'  },
     						{name : 'gname', type: 'String'  },
     						
     					  	{name : 'vgrpid', type: 'String'  },
     						{name : 'brand_name', type: 'String'  },
     						{name : 'brdid', type: 'String'  },
     						
     					  	{name : 'model', type: 'String'  },
     						{name : 'vmodid', type: 'String'  },
     						
     						{name : 'a_loc', type: 'String'  },
     						
     						{name : 'reg_no', type: 'String'  },
     						
     					
     			     		
     						            	
                          	],
             
                          	localdata: vehdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname =  function (row, column, value, data) {




            	if(typeof(data.days)=="undefined" || data.days=="" ){
            		return "greenClass";
                }
              
            var no=parseInt(column);
          var ss= $('#jqxfleetsearch').jqxGrid('getcellvalue', row, "days");
			          if(parseInt(ss)<0)
			  		{
			  		
			  		return "yellowClass";       /*   yellow - vehicle due pending */
			  	
			  		}
            	if(ss>=no)
            		{
            		
            		return "redClass";         /*   yellow - vehicle Not  available that date */
            	
            		}
            	  else{
                  	//alert(data.amount);
                  	return "greenClass"; /*   yellow - vehicle  available that date */
                  };
            	/* return "greyClass";
            	
			        var element = $(defaultHtml);
			        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
			        return element[0].outerHTML;
 */

			}
    	        
    	        
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxfleetsearch").jqxGrid(
            {
                width: '100%',
                height: 520,
                source: dataAdapter,
                columnsresize: true,
              /*   filtermode:'excel',
                filterable: true, */
               filterable: true,
              showfilterrow: true, 
                selectionmode: 'singlerow',
                pagermode: 'default',
                theme: theme,
                //Add row method
	
                columns: [
					
					{ text: 'FLEET', datafield: 'fleet_no', width: '5%'},
					{ text: 'FLEET NAME', datafield: 'flname', width: '12%'},
					{ text: 'Reg NO', datafield: 'reg_no', width: '5%'},
					{ text: ''+a1, datafield: '1', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a2, datafield: '2', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a3, datafield: '3', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a4, datafield: '4', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a5, datafield: '5', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a6, datafield: '6', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a7, datafield: '7', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a8, datafield: '8', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false },
					{ text: ''+a9, datafield: '9', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a10, datafield: '10', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a11, datafield: '11', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a12, datafield: '12', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a13, datafield: '13', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a14, datafield: '14', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a15, datafield: '15', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					
					{ text: ''+a16, datafield: '16', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a17, datafield: '17', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a18, datafield: '18', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a19, datafield: '19', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a20, datafield: '20', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false },
					{ text: ''+a21, datafield: '21', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false },
					{ text: ''+a22, datafield: '22', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a23, datafield: '23', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false },
					{ text: ''+a24, datafield: '24', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a25, datafield: '25', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false },
					{ text: ''+a26, datafield: '26', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a27, datafield: '27', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname , filterable: false},
					{ text: ''+a28, datafield: '28', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a29, datafield: '29', width: '3%', cellsalign: 'center', align:'center'  ,cellclassname: cellclassname, filterable: false},
					{ text: ''+a30, datafield: '30', width: '3%', cellsalign: 'center', align:'center' ,cellclassname: cellclassname, filterable: false},
					
					{ text: 'days', datafield: 'days', width: '5%', cellsalign: 'center', align:'center',hidden:true},
				
					{ text: 'Brand', datafield: 'brand_name', width: '27%' ,hidden:true},
						{ text: 'Brid', datafield: 'brdid', width: '10%' ,hidden:true},
						{ text: 'Model', datafield: 'model', width: '22%',hidden:true },
						{ text: 'modid', datafield: 'vmodid', width: '10%' ,hidden:true},
						{ text: 'Color', datafield: 'color', width: '15%',hidden:true },
						{ text: 'clrid', datafield: 'clrid', width: '10%',hidden:true  },
						{ text: 'grpid', datafield: 'vgrpid', width: '5%' ,hidden:true},
						{ text: 'Group', datafield: 'gname', width: '10%',hidden:true },
						{ text: 'a_loc', datafield: 'a_loc', width: '10%',hidden:true },
						
				
					]
            });
            
    /*         $("#jqxfleetsearch").jqxGrid('addrow', null,  {}); */ 
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	
              	 document.getElementById("fleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
              	  document.getElementById("bookbrand").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brand_name");
              	 document.getElementById("bookbrand").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brand_name");
                 document.getElementById("bookbrandid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "brdid");
                 
                 document.getElementById("bookmodel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "model");
                 document.getElementById("bookmodelid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "vmodid");
                 
                 document.getElementById("bookcolor").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "color");
                 document.getElementById("bookcolorid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "clrid");
                 
                 
                 document.getElementById("bookgroup").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "gname");
                 document.getElementById("bookgroupid").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "vgrpid");
                document.getElementById("vehloc").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
                 
                 
                $('#fleetwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>
    