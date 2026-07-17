<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%>
 <%
           	String salickdocno = request.getParameter("salickdocno")==null?"0":request.getParameter("salickdocno").trim();
           	  %> 
 
<script type="text/javascript">

	var salikdata;
	
   	var temp1='<%=salickdocno%>';

    if(temp1>0)
  	 {
      salikdata= '<%=cstd.reloadsalik(salickdocno)%>';

  	 } 
    else
  	 { 
    	salikdata;
  	 
  	 } 


$(document).ready(function () { 	
   
var source =
 {
 datatype: "json",
 datafields: [
             	{name : 'date' , type: 'date'},
             	{name : 'time' , type: 'string'},
               	{name : 'tagno' , type: 'string'},
            	{name : 'regno' , type: 'string'},
            	{name : 'fleetno', type: 'string'},
            	{name : 'transaction' , type: 'string'},
            	{name : 'direction' , type: 'string'},
            	{name : 'source' , type: 'string'},
          	 	{name : 'amount' , type:'number'},
        		{name : 'location' , type: 'string'},
        		{name : 'hiddate' , type: 'string'},
        		{name : 'hidtime' , type: 'string'}
        	
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
		disabled:true,
     selectionmode: 'singlecell',
   
     editable:true,
     handlekeyboardnavigation: function (event) {
        	
  /*   	 var cell1 = $('#salikgrid').jqxGrid('getselectedcell');
    	 if (cell1 != undefined && cell1.datafield == 'Source') {  
  		   var rows = $('#salikgrid').jqxGrid('getrows');
             var rowlength= rows.length;
             if(cell1.rowindex==rowlength-1)
             {
             	  
           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
           if (key == 9) {  
          	 $("#salikgrid").jqxGrid('addrow', null, {});      
           }
  	 }
  	 }
    	 */ 
    	 
    	 var cell1 = $('#salikgrid').jqxGrid('getselectedcell');
    	 if (cell1 != undefined && cell1.datafield == 'fleetno') {  
    	
            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
            if (key == 114) {  
             	 document.getElementById("rowindex1").value = cell1.rowindex;
           
       	  salickinfoSearchContent('salikfleetsearch.jsp');
            	 $('#salikgrid').jqxGrid('render');
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
                    { text: 'Fleet', datafield: 'fleetno', width: '8%',editable: false},
					{ text: 'Reg No', datafield: 'regno', width: '8%'},
					{ text: 'Tag No', datafield: 'tagno', width: '8%',editable: false},
                    { text: 'Date', datafield: 'date', width: '9%',columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy'},
					{ text: 'Time', datafield: 'time', width: '5%',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
			               editor.jqxDateTimeInput({ showCalendarButton: false });
			               
				             
			           }
					},
					{ text: 'Transaction', datafield: 'transaction', width: '10%'},
					{ text: 'Direction', datafield: 'direction', width: '12%'},
					{ text: 'Source', datafield: 'source', width: '12%'},
                    { text: 'Amount', datafield: 'amount', width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right'},
					{ text: 'Location', datafield: 'location', width: '16%'},
					{ text: 'hiddate', datafield: 'hiddate', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
					{ text: 'hiddtime', datafield: 'hidtime', width: '8%',editable:false, cellsalign: 'left',align: 'left',hidden:true}
				
	              ]
        });
   

  $("#salikgrid").jqxGrid('addrow', null, {});      
      
  
  if(($('#mode').val()=='A')||($('#mode').val()=='E'))
	{
	  $("#salikgrid").jqxGrid({ disabled: false}); 
	}
  $('#salikgrid').on('celldoubleclick', function (event) {
  	var columnindex1=event.args.columnindex;
    	  if(columnindex1 == 1)
    		  { 
  		
    	 var rowindextemp = event.args.rowindex;
    	    document.getElementById("rowindex1").value = rowindextemp;  
    	  $('#salikgrid').jqxGrid('clearselection');
    	  salickinfoSearchContent('salikfleetsearch.jsp');
    	
    		  } 
  

  });
  $("#salikgrid").on('cellvaluechanged', function (event) 
          {
          	
             
              var datafield = event.args.datafield;
            
              var rowBoundIndex = event.args.rowindex;
              // new cell value.

        
		       
              if(datafield=="time")
		        	  
		          {
		        	  
		        
		         $('#salikgrid').jqxGrid('setcellvalue', rowBoundIndex, "hidtime" ,$('#salikgrid').jqxGrid('getcelltext', rowBoundIndex, "time"));
		        	
		        	 
		          } 
		       
  		       
              if(datafield=="date")
		          {
		    	   
		       
		              var hidcldate = $('#salikgrid').jqxGrid('getcelltext', rowBoundIndex, "date");
		        	 // alert(text);
		        	  $('#salikgrid').jqxGrid('setcellvalue',rowBoundIndex, "hiddate",hidcldate);
		          }
		       
  		      
          });
  
         });
   </script>

          
  <div id="salikgrid"></div>  

  <input type="hidden" id="rowindex1"/> 
