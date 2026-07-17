<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>


   	<%
   	String docval = request.getParameter("docval")==null?"0":request.getParameter("docval").trim();
   	String groupval=request.getParameter("groupval")==null?"0":request.getParameter("groupval").trim();
	String branchval=request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();

   	%>
<script type="text/javascript">

var tariffdata='<%=cvd.tariffSearch(groupval,docval,branchval)%>';  

$(document).ready(function () { 
	
	var cellclassname;
	// var cellclass ;
    var num = 0; 
    
    
  
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
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
              	{name : 'chaufchg' , type:'number'},
              	{name : 'chaufexchg' , type:'number'}
              
              	
			   ],
			   localdata: tariffdata,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
	
 

    var cellsrenderer = function (row, column, value, defaultHtml) {
    				var rows11 = $("#jqxgridtarifrr").jqxGrid('getrows');
    					var rowval=rows11.length;
    				var row1=rowval-1;
    				var row2=rowval-2;
    				var row3=rowval-3;
    				var row4=rowval-4;
    				
    				
    			    if ( row == row1) {
    			    	
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#FBF3BA', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    			    if (row == row2) {
    			    	
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#d8bfd8', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    			   
    			    if (row == row3) {
    			    	
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#BAD4FB', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    			    if (row == row4) {
    			    	
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#ACF6CB', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    			    return defaultHtml;
    			}


 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#jqxgridtarifrr").jqxGrid(
   {
      width: '98%',
      height: 106,
      source: dataAdapter,
      columnsresize: true,
      rowsheight:20,
      editable:false,
      selectionmode: 'singlerow',
      pagermode: 'default',
      theme: theme,
     

    

      
       columns: [  
            
					{ text: '   '+document.getElementById("mainrentaltype").value,   datafield: 'rentaltype', editable:false, cellsalign: 'center', align:'center',cellsrenderer: cellsrenderer },
					 { text: '      '+document.getElementById("mainrate").value,     datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer },
					{ text: '      '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right', cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai").value,     	 datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right', cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincdw1").value,    	 datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai1").value,    	 datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maingps").value,      	 datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainbabyseater").value,  	 datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '  '+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '   '+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: '    '+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufchg").value,        datafield: 'chaufchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufexchg").value,      datafield: 'chaufexchg', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellsrenderer: cellsrenderer},
					
										]
      
        
					 }); 
   
   
   
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
   $('#jqxgridtarifrr').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
  

   
   
   
			   

		
			   
			   
});
    </script>

           
   <div id="jqxgridtarifrr"> </div>

	    <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 