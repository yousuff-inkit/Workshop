<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.operations.agreement.rentalagmtsayara.*" %>
 <%
 ClsRentalAgmtSayaraDAO viewDAO= new ClsRentalAgmtSayaraDAO();
String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno");
String regno = request.getParameter("regno")==null?"NA":request.getParameter("regno");
String flname = request.getParameter("flname")==null?"NA":request.getParameter("flname");
String color = request.getParameter("color")==null?"NA":request.getParameter("color");
String group = request.getParameter("group")==null?"NA":request.getParameter("group");

String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");


%>
 
 <script type="text/javascript">

<%--  
var trmps='<%=aa%>';
var vehdata;

 if(trmps!='NA')
	 { --%>

 var vehdata='<%=viewDAO.vehSearch(session,fleetno,regno,flname,color,group,aa)%>';

/* 
	 }
 else
	 {
	 vehdata;

	 } */
   // alert(data);
  /*  var url1='disfleetSearch.jsp'; */
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'color', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'gname', type: 'String'  },
     						{name : 'kmin', type: 'number'  },
     						{name : 'fin', type: 'String'  },
     						{name : 'a_loc', type: 'String'  },
     						{name : 'gid', type: 'String'  },
     						{name : 'hidfin', type: 'String'  },
     						{name : 'platecode',type:'string'}
     				                        	
                          	],
             
                          	localdata: vehdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
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
                height: 340,
                source: dataAdapter,
                columnsresize: true,
              
           /*    filterable: true,
              showfilterrow: true, */
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					{ text: 'FLEETNO', datafield: 'fleet_no', width: '13%'  },
					{ text: 'REGNO', datafield: 'reg_no', width: '17%' },
					{ text: 'NAME', datafield: 'flname', width: '35%'  },
					{ text: 'COLOR', datafield: 'color', width: '17%' },
					{ text: 'GROUP', datafield: 'gname', width: '18%' },
					{ text: 'Location', datafield: 'a_loc', width: '15%',hidden:true},
					{ text: 'GID', datafield: 'gid', width: '15%',hidden:true},
					{ text: 'KM', datafield: 'kmin', width: '15%',hidden:true},
					 { text: 'FUEL', datafield: 'fin', width: '15%',hidden:true},
					 { text: 'hideFUEL', datafield: 'hidfin', width: '15%',hidden:true},
					 { text: 'Plate Code',datafield:'platecode',width:'15%',hidden:true}
					
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
            	 var temp="";
            	temp=temp+" REG NO: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
                temp=temp+" , "+" NAME: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "flname");
                temp=temp+" , "+" GROUP: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "gname");
                temp=temp+" , "+" COLOR: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "color");
                temp=temp+" , "+" PLATE CODE: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "platecode");
                //temp=temp+","+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "kmout");
                
            	document.getElementById("vehdetails").value=temp; 
            	
            	document.getElementById("veh_fleetgrouptariff").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "gid");
               //  document.getElementById("doctype").value= $('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("txtfleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               document.getElementById("re_Km").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
               document.getElementById("ratariff_fuel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fin");
                              document.getElementById("payment_Conveh").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no")+" ("+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "reg_no")+" - "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "platecode")+")";

               document.getElementById("vehlocation").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
               
               document.getElementById("hidvehfuel").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "hidfin");
               
               
               $('#txtcusid').attr('disabled', false);
               document.getElementById("errormsg").innerText="";	   
               $("table#tariff input").prop("disabled", false);
               $('#delivery_chk').attr('disabled', false);
   	           $('#radrivercheck').attr('disabled', false); 
   	 	       $("#delcharges").attr("disabled", true);
   	 	       
   	 	       if( document.getElementById("delivery_chk").checked)
   	 	    	   {
   	 	    	  $("#delcharges").attr("disabled", false);
   	 	    	   }
   	 	       
   	            $("#tariffDivId").load('rateDescription.jsp?');
                $('#vehinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>