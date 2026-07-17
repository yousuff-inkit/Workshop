<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%>

 <%
           	String trfficdoc = request.getParameter("trafficdocno")==null?"0":request.getParameter("trafficdocno").trim();
 
 System.out.println("sdsd"+trfficdoc);
           	  %> 
 
<script type="text/javascript">

	var traficdata;

	   	var temp1='<%=trfficdoc%>';

	    if(temp1>0)
	  	 {
	    	traficdata= '<%=cstd.reloadtraffic(trfficdoc)%>';

	  	 } 
	    else
	  	 { 
	    	traficdata;
	  	 
	  	 } 	



$(document).ready(function () { 	
   
var source =
 {
 datatype: "json",
 datafields: [
             	{name : 'source' , type: 'string'},
             	{name : 'pltid' , type: 'string'},
             	{name : 'regno' , type: 'string'},
            	{name : 'fleetno', type: 'string'},
            	{name : 'finesource' , type: 'string'},
            	{name : 'fineno' , type: 'number'},
            	{name : 'date' , type: 'date'},
            	{name : 'time' , type: 'string'},
            	{name : 'amount' , type: 'number'},
          	 	{name : 'description' , type:'string'},
        		{name : 'location' , type: 'string'},
        		{name : 'hiddate' , type: 'string'},
        		{name : 'hidtime' , type: 'string'},
			{name : 'tcno' , type: 'string'}
        		
      
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
		disabled:true,
     selectionmode: 'singlecell',
   
     editable:true,
   
     handlekeyboardnavigation: function (event) {
     	
    	 var cell1 = $('#traficgrid').jqxGrid('getselectedcell');
    	 
    	 /* if (cell1 != undefined && cell1.datafield == 'description') {  
    		   var rows = $('#traficgrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(cell1.rowindex==rowlength-1)
               {
               	  
             var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
             if (key == 9) {  
            	 $("#traficgrid").jqxGrid('addrow', null, {});      
             }
    	 } 
    	 }*/
    	 if (cell1 != undefined && cell1.datafield == 'fleetno') {  
    	
            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
            if (key == 114) {  
             	 document.getElementById("rowindex").value = cell1.rowindex;
           
             	trafficinfoSearchContent('trafficfleetsearch.jsp');
            	 $('#traficgrid').jqxGrid('render');
            }
            }
        

  
  
      }, 
  
      columns: [
                

                
        	
        	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                 groupable: false, draggable: false, resizable: false,
                 datafield: 'sl', columntype: 'number', width: '3%',
                 cellsrenderer: function (row, column, value) {
                     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                 }  
               },
                 	{ text: 'Fleet', datafield: 'fleetno', width: '8%', editable: false},
                 	{ text: 'Reg No', datafield: 'regno', width: '8%', editable: false},
					{ text: 'Plate Source', datafield: 'source', width: '7%', editable: false},
					{ text: 'Plate Code', datafield: 'pltid', width: '5%', editable: false},
					{ text: 'Fine Source', datafield: 'finesource', width: '8%'},
                    { text: 'Fine No', datafield: 'fineno', width: '8%'},
                    { text: 'Date', datafield: 'date', width: '8%',columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy'},
					{ text: 'Time', datafield: 'time', width: '5%',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
			               editor.jqxDateTimeInput({ showCalendarButton: false });
			               
				             
			           }
					},
                    { text: 'Amount', datafield: 'amount', width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right'},
      			    { text: 'Description', datafield: 'description', width: '16%'},
					{ text: 'Location', datafield: 'location', width: '15%'},
					{ text: 'hiddate', datafield: 'hiddate', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'hiddtime', datafield: 'hidtime', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'tc_no', datafield: 'tcno', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
				
					
					
	              ]
        });
   

  $("#traficgrid").jqxGrid('addrow', null, {});      
      
  if(($('#mode').val()=='A')||($('#mode').val()=='E'))
	{
	  $("#traficgrid").jqxGrid({ disabled: false}); 
	}
$('#traficgrid').on('celldoubleclick', function (event) {
	var columnindex1=event.args.columnindex;
  	  if(columnindex1 == 1)
  		  { 
		
  	 var rowindextemp = event.args.rowindex;
  	    document.getElementById("rowindex").value = rowindextemp;  
  	  $('#traficgrid').jqxGrid('clearselection');
  	trafficinfoSearchContent('trafficfleetsearch.jsp');
  	
  		  } 


});
   		 
$("#traficgrid").on('cellvaluechanged', function (event) 
        {
        	
           
            var datafield = event.args.datafield;
          
            var rowBoundIndex = event.args.rowindex;
            // new cell value.

      
		       
            if(datafield=="time")
		        	  
		          {
		        	  
		        
		         $('#traficgrid').jqxGrid('setcellvalue', rowBoundIndex, "hidtime" ,$('#traficgrid').jqxGrid('getcelltext', rowBoundIndex, "time"));
		        	
		        	 
		          } 
		       
		       
            if(datafield=="date")
		          {
		    	   
		       
		              var hidcldate = $('#traficgrid').jqxGrid('getcelltext', rowBoundIndex, "date");
		        	 // alert(text);
		        	  $('#traficgrid').jqxGrid('setcellvalue',rowBoundIndex, "hiddate",hidcldate);
		          }
		       
		      
        });
   		 
   		 
   		 
   		 
         });
   </script>

          
  <div id="traficgrid"></div>  

  <input type="hidden" id="rowindex"/> 

