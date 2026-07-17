<%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO" %>
<% ClsTrafficfineDAO ctf=new ClsTrafficfineDAO();%>

 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String type = request.getParameter("emptype")==null?"0":request.getParameter("emptype").trim();
 String employee = request.getParameter("empname")==null?"0":request.getParameter("empname").trim();%>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		data1='<%=ctf.staffAllocatedGridLoading(branchval,fromDate, toDate, type, employee)%>';
    }
   
        $(document).ready(function () { 	
    
        	        
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'ticket_no', type: 'string'    },
     						{name : 'emp_type', type: 'string'    },
     						{name : 'sal_name', type: 'string'    },
     						{name : 'totalamount', type: 'string'   },
     						{name : 'st_desc', type: 'string'  },
     						{name : 'trafficacc', type: 'int'  },
     						{name : 'accno', type: 'int'    },
     						{name : 'mainbranch', type: 'int'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'emp_id', type: 'string'  },
     						{name : 'amountcount', type: 'int'  },
     						{name : 'empinfo', type: 'string'  }
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
            
            $("#jqxstaffAllocatedTraffic").jqxGrid(
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
							
							{ text: 'Reg No.', datafield: 'regno', width: '7%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '7%' },
							{ text: 'Location', datafield: 'location', width: '18%' },
							{ text: 'Source', datafield: 'source', width: '16%' },
							{ text: 'Ticket No.', datafield: 'ticket_no', width: '7%' },
							{ text: 'Emp. Type', datafield: 'emp_type', width: '7%' },
							{ text: 'Emp. Name', datafield: 'sal_name', width: '28%' },
							{ text: 'Amount', datafield: 'totalamount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Status', datafield: 'st_desc', hidden: true, width: '10%' },
							{ text: 'Traffic Account', datafield: 'trafficacc', hidden: true, width: '10%' },
							{ text: 'Employee Account', datafield: 'accno', hidden: true, width: '10%' },
							{ text: 'Main Branch', datafield: 'mainbranch', hidden: true, width: '10%' },
							{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Sr No', datafield: 'sr_no', hidden: true, width: '10%' },
							{ text: 'Emp Id', datafield: 'emp_id', hidden: true, width: '10%' },
							{ text: 'Amt Count', datafield: 'amountcount', hidden: true, width: '10%' },
							{ text: 'Emp Info', datafield: 'empinfo', hidden: true, width: '10%' },
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxstaffAllocatedTraffic").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxstaffAllocatedTraffic').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txttrafficaccount").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "trafficacc");
                document.getElementById("txtexpenseaccount").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "accno");
                document.getElementById("txtrano").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "st_desc");
                document.getElementById("txtfleetno").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "fleetno");
                document.getElementById("txtticketno").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "ticket_no");
                document.getElementById("txtamount").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "totalamount");
                document.getElementById("txtamountcount").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "amountcount");
                document.getElementById("txtmainbranch").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "mainbranch");
                document.getElementById("txtdocno").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtsrno").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "sr_no");
                document.getElementById("txtemployeeid").value = $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue', rowindex1, "emp_id");
                
                var values= $('#jqxstaffAllocatedTraffic').jqxGrid('getcellvalue',rowindex1, "empinfo");
                
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("vehinfo").value=sum2;
            });  
        });
    </script>
    <div id="jqxstaffAllocatedTraffic"></div>
