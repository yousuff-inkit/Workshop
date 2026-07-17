<%@page import="com.operations.agreement.rentalclose.ClsRentalCloseDAO"%>
<%String agmtno=request.getParameter("id")==null?"0":request.getParameter("id"); 
ClsRentalCloseDAO closedao=new ClsRentalCloseDAO();
%>
<style>
.column{
background-color: #D6FFEA;
}
</style>
 <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 
<script type="text/javascript">

/* $('#frmTariffManagement select').attr('disabled', false);  */
var tempid='<%=agmtno%>';
      var datareference;
      if(tempid!=''){
    	  datareference='<%=closedao.getReferenceTarif(agmtno)%>';  
      }
     

        $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
{name : 'rentaltype' , type: 'string', },
	{name : 'rate' , type:'number'},
	{name : 'cdw' , type:'number'},
	{name : 'pai' , type:'number'},
	{name : 'cdw1' , type:'number'},
	{name : 'pai1' , type:'number'},
	{name : 'gps' , type:'number'},
	{name : 'babyseater' , type:'number'},
	{name : 'cooler' , type:'number'},
	{name : 'exhrchg' , type:'number'},
	{name : 'chaufchg' , type:'number'},
	{name : 'chaufexchg' , type:'number'},
 {name : 'kmrest' , type:'number'},
	{name : 'exkmrte' , type:'number'},
	{name : 'oinschg' , type:'number'}
                 ],
                localdata: datareference,
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
            $("#tarifreferencegrid").jqxGrid(
            {
                width: '100%',
                height: 80,
                source: dataAdapter,
                rowsheight:18,
                disabled:true,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
{ text: '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype',editable:false},
{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: '     '+document.getElementById("maincdw").value,  datafield: 'cdw',renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
{ text: '     '+document.getElementById("mainpai").value,  datafield: 'pai',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
{ text: '     '+document.getElementById("maincdw1").value,  datafield: 'cdw1' ,editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: '     '+document.getElementById("mainpai1").value,  datafield: 'pai1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text:  '     '+document.getElementById("maingps").value,  datafield: 'gps', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainbabyseater").value,  datafield: 'babyseater', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("maincooler").value,  datafield: 'cooler', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainkmrest").value,  datafield: 'kmrest',  editable:true,renderer: columnsrenderer,cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainexkmrte").value,  datafield: 'exkmrte', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainoinschg").value,  datafield: 'oinschg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainexhrchg").value,  datafield: 'exhrchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right'},
{ text: ''+document.getElementById("mainchaufexchg").value,  datafield: 'chaufexchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right'}
	              ]
            });
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
            $('#tarifreferencegrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
            if(document.getElementById("agreementno").value==''){
                $("#tarifreferencegrid").jqxGrid("addrow", null, {});

            }
            var rows=$("#tarifreferencegrid").jqxGrid("getrows");
            if(rows.length==0){
            	$("#tarifreferencegrid").jqxGrid("addrow", null, {});
            }
            $('#tarifreferencegrid').on('rowclick', function (event) {
            	var row1=event.args.rowindex;
                $("#tarifreferencegrid").jqxGrid("addrow", null, {});
                var rows=$("#tarifreferencegrid").jqxGrid("getrows");
            	var rowlength=rows.length-1;
            	$('#tarifreferencegrid').jqxGrid('setcellvalue', rowlength, "rentaltype",$('#tarifreferencegrid').jqxGrid('getcellvalue', row1, "rentaltype"));
var cols = $("#tarifreferencegrid").jqxGrid("columns");
for (var i = 1; i < cols.records.length; i++) {
   var textData = cols.records[i].datafield;
   if($('#tarifagmtgrid').jqxGrid('getcellvalue', 0, textData)>0){
	   $('#tarifreferencegrid').jqxGrid('setcellvalue', rowlength, textData,$('#tarifreferencegrid').jqxGrid('getcellvalue', row1, textData));
   } 
   else{
	   $('#tarifreferencegrid').jqxGrid('setcellvalue', rowlength, textData,0);
   }
}
            });
        });
            </script>
            <div id="tarifreferencegrid"></div>