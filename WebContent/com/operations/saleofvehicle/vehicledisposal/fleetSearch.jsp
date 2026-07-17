
<%@page import="com.operations.saleofvehicle.vehicledisposal.ClsVehicleDisposalDAO"%>
<%String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
ClsVehicleDisposalDAO disposaldao=new ClsVehicleDisposalDAO();
%>
<script type="text/javascript">
      var datafleet= '<%=disposaldao.fleetSearch(branch)%>';
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'platecode',type:'string'},
     						{name : 'reg_no',type:'string'},
     						{name : 'chassisno',type:'string'}
     						
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
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
			    filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Fleet No',filtertype:'input',columntype:'textbox', datafield: 'fleet_no', width: '20%' },
							{ text: 'Fleet Name',filtertype:'input',columntype:'textbox', datafield: 'flname', width: '35%'},
							{ text: 'Chassis No',filtertype:'input',columntype:'textbox', datafield: 'chassisno', width: '15%'},
							{ text: 'Reg No',filtertype:'input',columntype:'textbox', datafield: 'reg_no', width: '15%'},
							{ text: 'Plate Code',filtertype:'input',columntype:'textbox',datafield:'platecode',width:'15%'}
						
							]
            });
           
           $('#fleetSearch').on('rowdoubleclick', function (event) {
        	   var row2=event.args.rowindex;
           	var row5=document.getElementById("disposalrow").value;
           	var fleetno=$('#fleetSearch').jqxGrid('getcellvalue', row2, "fleet_no");
           	var fleetname=$('#fleetSearch').jqxGrid('getcellvalue', row2, "flname");
           	var reg_no=$('#fleetSearch').jqxGrid('getcellvalue', row2, "reg_no");
               $("#disposalGrid").jqxGrid('setcellvalue', row5, "fleet_no", fleetno);
               $("#disposalGrid").jqxGrid('setcellvalue', row5, "flname", fleetname);
               $("#disposalGrid").jqxGrid('setcellvalue', row5, "reg_no", reg_no);
               $("#disposalGrid").jqxGrid('addrow', null, {});
               $('#fleetwindow').jqxWindow('close');
            }); 
        
        });
    </script>
    <div id="fleetSearch"></div>