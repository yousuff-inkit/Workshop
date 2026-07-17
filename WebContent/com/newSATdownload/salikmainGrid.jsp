<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
 
<script type="text/javascript">

	var salikdata;
	



$(document).ready(function () { 	
   
var source =
 {
 datatype: "json",
 datafields: [
             	{name : 'date' , type: 'date'},
             	{name : 'time' , type: 'string'},
             	{name : 'salikuser' , type: 'string'},
            	{name : 'tagno' , type: 'string'},
            	{name : 'regno' , type: 'string'},
            	{name : 'fleetno', type: 'string'},
            	{name : 'transaction' , type: 'string'},
            	{name : 'direction' , type: 'string'},
            	{name : 'source' , type: 'string'},
          	 	{name : 'amount' , type:'number'},
        		{name : 'location' , type: 'string'},
        		{name : 'hiddate' , type: 'string'}
        	
			   ],
			localdata: salikdata,
      
      pager: function (pagenum, pagesize, oldpagenum) {
          // callback called when a page or pagse size is changed.
      }
};

var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
           //alert(error);
        }
      });

  $("#salikgrid").jqxGrid(
  {
     width: '100%',
     height: 300,
      source: dataAdapter,

     selectionmode: 'singlecell',
   
     editable:true,
   

      columns: [
        	
        	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                 groupable: false, draggable: false, resizable: false,
                 datafield: 'sl', columntype: 'number', width: '2%',
                 cellsrenderer: function (row, column, value) {
                     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                 }  
               },
        	
					{ text: 'Date', datafield: 'date', width: '9%'},
					
					{ text: 'Time', datafield: 'time', width: '3%',},
					{ text: 'Salikuser', datafield: 'salicuser', width: '13%'},
					{ text: 'Tagno', datafield: 'tagno', width: '6%'},
					{ text: 'Regno', datafield: 'regno', width: '6%'},
                { text: 'Fleetno', datafield: 'fleetno', width: '6%'},
					{ text: 'Transaction', datafield: 'transaction', width: '10%'},
					{ text: 'Direction', datafield: 'direction', width: '10%'},
					{ text: 'Source', datafield: 'source', width: '11%'},
                  { text: 'Amount', datafield: 'amount', width: '9%'},
					{ text: 'Location', datafield: 'location', width: '15%'},
					{ text: 'hiddate', datafield: 'hiddate', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
				
					
					
	              ]
        });
   

  $("#salikgrid").jqxGrid('addrow', null, {});      
      

   		 
         });
   </script>

          
  <div id="salikgrid"></div>  


