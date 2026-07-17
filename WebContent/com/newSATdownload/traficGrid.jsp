<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.NewSatDownload.SATdownloadDAO" %>
 
<script type="text/javascript">

	var traficdata;
	



$(document).ready(function () { 	
   
var source =
 {
 datatype: "json",
 datafields: [
             	{name : 'paltesource' , type: 'string'},
             	{name : 'platecode' , type: 'string'},
             	{name : 'regno' , type: 'string'},
            	{name : 'fleetno', type: 'string'},
            	{name : 'finesource' , type: 'date'},
            	{name : 'fineno' , type: 'string'},
            	{name : 'date' , type: 'date'},
            	{name : 'time' , type: 'string'},
            	{name : 'amount' , type: 'number'},
          	 	{name : 'discription' , type:'string'},
        		{name : 'location' , type: 'string'},
        		{name : 'hiddate' , type: 'string'}
        	
			   ],
			localdata: traficdata,
      
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

  $("#traficgrid").jqxGrid(
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
        	
					{ text: 'paltesource', datafield: 'paltesource', width: '9%'},
					
					{ text: 'platecode', datafield: 'platecode', width: '10%',},
					{ text: 'regno', datafield: 'regno', width: '13%'},
					{ text: 'fleetno', datafield: 'fleetno', width: '6%'},
					
					{ text: 'finesource', datafield: 'finesource', width: '6%'},
                { text: 'fineno', datafield: 'fineno', width: '6%'},
					{ text: 'date', datafield: 'date', width: '10%'},
					{ text: 'time', datafield: 'time', width: '3%'},
		
                  { text: 'Amount', datafield: 'amount', width: '9%'},
      			{ text: 'discription', datafield: 'discription', width: '11%'},
					{ text: 'Location', datafield: 'location', width: '15%'},
					{ text: 'hiddate', datafield: 'hiddate', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
				
					
					
	              ]
        });
   

  $("#traficgrid").jqxGrid('addrow', null, {});      
      

   		 
         });
   </script>

          
  <div id="traficgrid"></div>  


