

<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>

 <%         
	String qutdocno2 = request.getParameter("qutdocno2")==null?"0":request.getParameter("qutdocno2").trim();
           
           	  %> 


<script type="text/javascript">

var temp1='<%=qutdocno2%>';

var hide;

if(temp1>0)
	 {
	var tarifcal= '<%=viewDAO.tarifsaverelode(qutdocno2)%>';
	   hide=2; 
	 } 
else
	{
	   hide=10;
	var tarifcal;
	}
$(document).ready(function () { 
	
	var cellclassname;

    var num = 0; 
  
    
    
    
var source =
  {
  datatype: "json",
  datafields: [
               {name : 'group1' , type: 'string' },
               {name : 'grpid' , type: 'string' },
               	{name : 'rentaltype' , type: 'string' },
              	{name : 'rate' , type:'number'},
              	{name : 'cdw' , type:'number'},
              	{name : 'pai' , type:'number'},
              	{name : 'cdw1' , type:'number'},
              	{name : 'pai1' , type:'number'},
              	{name : 'gps' , type:'number'},
              	{name : 'babyseater' , type:'number'},
              	{name : 'cooler' , type:'number'},
              	 {name : 'kmrest' , type:'number'},
              	{name : 'exkmrte' , type:'number'},
              	{name : 'oinschg' , type:'number'},
              	{name : 'exhrchg' , type:'number'},
              	{name : 'sr_no', type: 'int'  },
              	{name : 'tdocno', type: 'int'  },
             
			   ],
			   localdata: tarifcal,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
   


    



 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#tarifcalGrid").jqxGrid(
   {
      width: '100%',
      height: 86,
      source: dataAdapter,
      disabled:true,
      rowsheight:20,
      editable:false,
      selectionmode: 'singlecell',
      pagermode: 'default',
      theme: theme,
     


      

      
       columns: [
                 
                 
                 { text: 'SL#', sortable: false, filterable: false, editable: false,
                     groupable: false, draggable: false, resizable: false,
                     datafield: 'sl', columntype: 'number', width: '2%',
                     cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                     }  
                   },
                   { text: 'Group', datafield: 'group1', width: '4%',editable:false, cellsalign: 'center', align:'center' },
                   { text: 'Group', datafield: 'grpid', width: '4%',editable:true, cellsalign: 'center', align:'center',hidden:true },
                   { text: '   '+document.getElementById("mainrentaltype").value,   datafield: 'rentaltype', editable:false, cellsalign: 'center', align:'center' },
                   { text: '      '+document.getElementById("mainrate").value,      datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right' },
                   { text: '     '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right'},
                   { text: '     '+document.getElementById("mainpai").value,     	datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: '     '+document.getElementById("maincdw1").value,    	datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: '     '+document.getElementById("mainpai1").value,    	datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: '     '+document.getElementById("maingps").value,        datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("mainbabyseater").value,  	datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true, cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},
                   { text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right'},	
           		    { text: 'tdocno', datafield: 'tdocno', width: '9%',hidden:true},
					{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
					
										]
              
					 }); 
   
   
   
   
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#tarifcalGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   
   if(hide=='10')
   {
   $("#tarifcalGrid").jqxGrid('addrow', null,  {});
 
   
   } 
   
  /*  if(hide==2)
	{
	   $("#tarifcalGrid").jqxGrid({ disabled: false});
	} */
   
   if(($('#mode').val()=='A')||($('#mode').val()=='E'))
	{
	  $("#tarifcalGrid").jqxGrid({ disabled: false}); 
	}
   
         });
    </script>

           
   <div id="tarifcalGrid"> </div> 
