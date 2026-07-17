<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
<%@page import="com.operations.agreement.nonpoolcreate.ClsNonPoolCreateDAO"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno");
String color=request.getParameter("color")==null?"0":request.getParameter("color");
String group=request.getParameter("group")==null?"0":request.getParameter("group");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
ClsNonPoolCreateDAO  nonpooldao=new ClsNonPoolCreateDAO();
%> 
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var datafleet= '<%=nonpooldao.fleetSearch(branch,searchdate,fleetno,docno,regno,color,group)%>';
		$(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'fin', type: 'String'  },
     						{name : 'tin',type:'String'},
     						{name : 'din',type:'date'},
     						{name : 'kmin',type:'number'}, 
     						{name : 'reg_no',type:'String'},
     						{name : 'flname',type:'String'},
     						{name : 'color',type:'String'},
     						{name : 'gid',type :'String'},
     						//{name : 'ilocid',type :'String'},
     						{name : 'date',type:'date'},
     						{name :'doc_no',type:'String'}
     					
                 ],
                localdata: datafleet,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#fleetSearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Fleet No', datafield: 'fleet_no', width: '16.66%' },
							 { text: 'Fuel', datafield: 'fin', width: '80%',hidden:true },
							{ text: 'Time', datafield: 'tin', width: '80%' ,hidden:true},
							{ text: 'Date', datafield: 'din', width: '80%' ,hidden:true,cellsformat:'dd.MM.yyyy'},
							{ text: 'KM', datafield: 'kmin', width: '80%',hidden:true,cellsformat:'d2' },
 							{ text: 'Reg No', datafield: 'reg_no', width: '16.66%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '40%',hidden:true},
							{ text: 'Color', datafield: 'color', width: '16.66%' },
							{ text: 'Group', datafield: 'gid', width: '16.66%'},
	/* 						{ text: 'Location', datafield: 'ilocid', width: '80%',hidden:true }, */
							{ text: 'Date', datafield: 'date', width: '16.66%' ,cellsformat:'dd.MM.yyyy'},
							{ text:'Doc No',datafield:'doc_no',width:'16.66%'}
							]
            });
           
           $('#fleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	var temp="";
              
            	document.getElementById("fleetno").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
 				temp=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "flname");
 				temp=temp+", Reg No: "+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
 				temp=temp+", Color: "+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "color");
 				temp=temp+", Group: "+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "gid");
 				document.getElementById("fleetname").value=temp;
            	$('#fleetwindow').jqxWindow('close');
                $('#datein').jqxDateTimeInput('val',$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "din"));
                if($('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "tin")=="NA"){
                	$('#timein').jqxDateTimeInput('val',null);
                }
                else{
                	$('#timein').jqxDateTimeInput('val',$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "tin"));
                }
                $('#inkm').val($('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "kmin"));
                $('#cmbinfuel').val($('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fin"));
            }); 
         
        });
    </script>
    <div id="fleetSearch"></div>
