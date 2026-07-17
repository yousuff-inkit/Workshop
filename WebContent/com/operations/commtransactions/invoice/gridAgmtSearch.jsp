<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO1"%>
<%
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile"); 
String license=request.getParameter("license")==null?"":request.getParameter("license"); 
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();
%>
<script type="text/javascript">

    
      var rasdata='<%=invdao.getAgmtnoSearch(docno,fleet,regno,client,agmttype,date,mobile,license,branch)%>';	
      
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'voc_no',type:'int'},
     						{name : 'cldocno', type: 'int'  },
     						{name : 'ofleet_no', type: 'String'},
     						{name : 'refname', type: 'String'},
     						{name : 'address', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						{name : 'name', type: 'String'},
     						{name : 'mobno', type: 'String'}, 
     						{name : 'dlno', type: 'String'},
     						{name : 'acno', type: 'String'},
     						{name : 'reg_no',type:'String'},
     						{name : 'flname',type:'String'},
     						{name : 'fleet_no',type:'String'},
     						{name : 'email',type:'String'}
                 ],
                localdata: rasdata,
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
            $("#gridAgmtSearch").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Master Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Client No', datafield: 'cldocno', width: '60%',hidden:true },
							{ text: 'Fleet', datafield: 'ofleet_no', width: '10%' },
						 	{ text: 'Client', datafield: 'refname', width: '40%'},
							{ text: 'Address', datafield: 'address', width: '30%',hidden:true},
							{ text: 'Mobile', datafield: 'per_mob', width: '10%' },
							{ text: 'Driver', datafield: 'name', width: '30%',hidden:true },
							{ text: 'Mobile', datafield: 'mobno', width: '10%' },
							{ text: 'License', datafield: 'dlno', width: '10%' },
							{ text: 'Account', datafield: 'acno', width: '30%',hidden:true },
							{ text: 'RegNo', datafield:'reg_no',width:'10%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true },
							{ text:'Fleet',datafield:'fleet_no',width:'30%',hidden:true},
							{ text:'E-mail',datafield:'email',width:'30%',hidden:true}
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
            $('#gridAgmtSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
   				document.getElementById("agmtno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
   				document.getElementById("agmtvoucherno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				var temp="";
				var temp2="";
				var temp3="";
				var temp4="";
				document.getElementById("email").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "email");
				document.getElementById("acno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "acno");
				document.getElementById("hidclient").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				document.getElementById("client").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				temp="Address:"+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "address");
				temp=temp+"Phone:"+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				document.getElementById("clientdetails").value=temp;
				document.getElementById("driver").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "name");
				temp2="Mobile:"+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "mobno");
				temp2=temp2+"License No:"+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "dlno");
				document.getElementById("driverdetails").value=temp2;
				temp3="Fleet: "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "ofleet_no");
				temp3=temp3+" "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "flname");
				temp3=temp3+" Reg No: "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
				document.getElementById("contractvehicle").value=temp3;
				temp4="Fleet: "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
				temp4=temp4+" "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "flname");
				temp4=temp4+" Reg No: "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
				document.getElementById("vehicledetails").value=temp4;
				
              $('#agmtnowindow').jqxWindow('close');
               
                
            });  
        });
    </script>
    <div id="gridAgmtSearch"></div>
