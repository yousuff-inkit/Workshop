
<style>
.column{
background-color: #D6FFEA;
}
</style>
 <%String agmtno=request.getParameter("id")==null?"0":request.getParameter("id").toString(); %> 
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
$(document).ready(function () { 
 var trafficdata;
 var tempagmt='<%=agmtno%>';
 if(tempagmt!="0"){
	<%--  trafficdata='<%=com.operations.agreement.rentalclose.ClsRentalCloseDAO.getTrafficdata(agmtno)%>'; --%>
 }
 
  var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
									{name : 'regno' , type: 'String' },
									{name : 'ticket_no' , type:'String'},
									{name : 'time' , type:'date'},
									{name : 'traffic_date' , type:'date'},
									{name : 'fleetno' , type:'String'},
									{name : 'amount' , type:'number'},
									{name : 'inv_no' , type:'String'},
									{name : 'desc1' , type:'String'}
									
                 ],
                localdata: trafficdata,
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
            $("#trafficGrid").jqxGrid(
            {
                width: '100%',
                height: 80,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
{ text: 'Fleet No', datafield: 'fleetno', width: '10%',cellclassname:'column'},
{ text: 'Reg No',  datafield: 'regno',  width: '10%',renderer: columnsrenderer,cellclassname:'column'},
{ text: 'Ticket No',  datafield: 'ticket_no',  width: '10%'  ,renderer: columnsrenderer, cellsalign: 'right', cellclassname:'column'},
{ text: 'Traffic Date',  datafield: 'traffic_date',  width: '10%',renderer: columnsrenderer, cellclassname:'column',cellsformat: 'dd.MM.yyyy',columntype:"datetimeinput"
     },
{ text: 'Time',  datafield: 'time',  width: '10%'  ,renderer: columnsrenderer, cellclassname:'column',cellsformat: 'HH:mm',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
     editor.jqxDateTimeInput({ showCalendarButton: false });
}},
{ text: 'Inv No',  datafield: 'inv_no',  width: '10%',renderer: columnsrenderer, cellclassname:'column'},
{ text: 'Description',  datafield: 'desc1',  width: '30%',renderer: columnsrenderer, cellclassname:'column'},
{ text: 'Amount',  datafield: 'amount',  width: '10%',renderer: columnsrenderer,cellsformat: 'd2', cellclassname:'column',cellsalign:'right'}

	              ]
            });
            if(document.getElementById("agreementno").value==''){
            $("#trafficGrid").jqxGrid("addrow", null, {});
            }
            var rows=$("#trafficGrid").jqxGrid("getrows");
            var rowlength=rows.length;
            if(rowlength==0){
                 $("#trafficGrid").jqxGrid("addrow", null, {});
            }
        });
            </script>
            <div id="trafficGrid"></div>