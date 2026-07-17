<%@page import="com.dashboard.operations.staffallocateddamage.ClsStaffAllocatedDamageDAO" %>
<% ClsStaffAllocatedDamageDAO cad=new ClsStaffAllocatedDamageDAO();%>


 <%String branchval = request.getParameter("branchval")==null || request.getParameter("branchval").trim().equalsIgnoreCase("")?"0":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null || request.getParameter("fromdate").trim().equalsIgnoreCase("")?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null || request.getParameter("todate").trim().equalsIgnoreCase("")?"0":request.getParameter("todate").trim();
 String type = request.getParameter("emptype")==null || request.getParameter("emptype").trim().equalsIgnoreCase("")?"0":request.getParameter("emptype").trim();
 String employee = request.getParameter("empname")==null?"0":request.getParameter("empname").trim();%>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 
 	if(temp!='0'){ 
 		data1='<%=cad.staffAllocatedGridLoading(branchval,fromDate,toDate,type,employee)%>';
    }
 	
        $(document).ready(function () { 	
    
        	/*$("#btnExcel").click(function() {
    			$("#jqxstaffalocateddamage").jqxGrid('exportdata', 'xls', 'Staff-Allocated-Damage');
    		});*/            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'inspno',type: 'string'},
     						{name : 'refno',type:'string'},
     						{name : 'type',type:'string'},
     						{name : 'emp_type', type: 'string'    },
     						{name : 'sal_name', type: 'string'    },
     						{name : 'amount', type: 'string'   },
     						{name : 'details',type:'String'},
     						{name : 'damageacc',type:'String'},
     						{name : 'expacc',type:'String'},
     						{name : 'brhid',type:'string'},
     						{name : 'empno',type:'string'},
     						{name : 'date',type:'string'}
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxstaffalocateddamage").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							
							{ text: 'Reg No.', datafield: 'regno', width: '10%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
							{ text: 'Inspection No',datafield:'inspno',width:'10%'},
							{ text: 'Ref No',datafield:'refno',width:'10%'},
							{ text: 'Type',datafield:'type',width:'10%'},
							{ text: 'Emp. Type', datafield: 'emp_type', width: '10%' },
							{ text: 'Emp. Name', datafield: 'sal_name', width: '30%' },
							{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Details', datafield: 'details', width: '10%',hidden:true},
							{ text: 'Damage Account', datafield: 'damageacc', width: '10%',hidden:true},
							{ text: 'Expense Account', datafield: 'expacc', width: '10%',hidden:true},
							{ text: 'Branch',datafield:'brhid',width:'10%',hidden:true},
							{ text: 'Employee',datafield:'empno',width:'10%',hidden:true},
							{ text: 'date',datafield:'date',width:'10%',hidden:false}
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxstaffalocateddamage").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxstaffalocateddamage').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdate").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "date");
                 document.getElementById("txtsalikaccount").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "damageacc");
                document.getElementById("txtexpenseaccount").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "expacc");
                //document.getElementById("txtrano").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "ra_no");
                document.getElementById("txtfleetno").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "fleetno");
                document.getElementById("txtamount").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "amount");
                //document.getElementById("txtamountcount").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "amountcount");
                document.getElementById("txtmainbranch").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "brhid");
                document.getElementById("txtdocno").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "inspno");
                document.getElementById("txtsrno").value ="1";
                document.getElementById("txtemployeeid").value = $('#jqxstaffalocateddamage').jqxGrid('getcellvalue', rowindex1, "empno");
                
                
                var values= $('#jqxstaffalocateddamage').jqxGrid('getcellvalue',rowindex1, "details");
                
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("vehinfo").value=sum2;
            });  
        });
    </script>
    <div id="jqxstaffalocateddamage"></div>
    <input type="hidden" name="inspno" id="inspno">
