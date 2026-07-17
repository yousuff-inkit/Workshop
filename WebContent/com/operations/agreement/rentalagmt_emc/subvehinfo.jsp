<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 
 <%@page import="com.operations.agreement.rentalagmtemc.ClsRentalAgmtEMCDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
 <%
 ClsRentalAgmtEMCDAO viewDAO= new ClsRentalAgmtEMCDAO();

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
     						{name : 'platecode',type:'string'},
     				        {name : 'mraconfig',type:'number'},
     				        {name : 'din',type:'date'},
     				        {name : 'tin',type:'string'},
     				        {name : 'emcrate',type:'number'},
     				        {name : 'totalkm',type:'number'}
     						
     				                        	
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
					 { text: 'Plate Code',datafield:'platecode',width:'15%',hidden:true},
					 { text: 'MRA Config',datafield:'mraconfig',width:'15%',hidden:true},
					{ text: 'Date In',datafield:'din',width:'10%',hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'Time In',datafield:'tin',width:'10%',hidden:true},
					{ text: 'Emc Rate',datafield:'emcrate',width:'10%',hidden:true,cellsformat:'d2'},
					{ text: 'Total KM',datafield:'totalkm',width:'10%',hidden:true,cellsformat:'d2'}
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            { 
              	var rowindex1=event.args.rowindex;
            	var temp="";
				$('#mraconfig').val($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "mraconfig"));
            	temp=temp+" REG NO: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
                temp=temp+" , "+" NAME: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "flname");
                temp=temp+" , "+" GROUP: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "gname");
                temp=temp+" , "+" COLOR: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "color");
                temp=temp+" , "+" PLATE CODE: "+$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "platecode");
            	document.getElementById("fleetdetails").value=temp;
            	$('#movdin').jqxDateTimeInput('setDate',$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "din"));
            	$('#movtin').jqxDateTimeInput('setDate',$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "tin"));
            	$('#movkmin,#outkm').val($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "kmin"));
            	$('#movfin,#cmboutfuel').val($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "hidfin"));
               	document.getElementById("fleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");              
                $('#rate').val($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "emcrate"));
                $('#outkm').val($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "totalkm"));
               	$('#vehinfowindow').jqxWindow('close');
                
            	
            }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>