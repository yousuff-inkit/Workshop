<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
 String driverid = request.getParameter("driverid")==null?"0":request.getParameter("driverid");
 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
 String clientaccount = request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
 		var data1='<%=DAO.clientSearch(session,clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'clientid', type: 'int'  },
     						{name : 'refname', type: 'String' },
     						{name : 'account', type: 'String' },
     						{name : 'dob', type: 'date' },
     						{name : 'per_tel', type: 'String' }, 
     						{name : 'per_mob', type: 'String' },
     						{name : 'visano', type: 'String'  },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' }
                          	],
                          	localdata: data1,
                
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
            $("#jqxclientsearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Client#', datafield: 'clientid', width: '6%' },
					 { text: 'Name', datafield: 'refname', width: '28%' },
					 { text: 'Account', datafield: 'account', width: '7%' },
					 { text: 'DOB', datafield: 'dob', width: '9%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Tel', datafield: 'per_tel', width: '10%' }, 
					 { text: 'Mob', datafield: 'per_mob', width: '12%' },
					 { text: 'ID#', datafield: 'visano', width: '9%' },
					 { text: 'Licence#', datafield: 'dlno', width: '9%' },
					 { text: 'Nation', datafield: 'nation', width: '10%' },
					]
            });
            
			  $('#jqxclientsearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                var rowindex2 =$('#rowindex').val();
				funReset();
                document.getElementById("txtclient_name").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("docno").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
                document.getElementById("txtpersonal_tel1").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex2, "doc_no" ,$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientid"));
                
                $('#frmClientMaster select').attr('disabled', false);
                $('#jqxClientDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmClientMaster").submit();
                $('#frmClientMaster select').attr('disabled', true);
                $('#jqxClientDate').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>
    