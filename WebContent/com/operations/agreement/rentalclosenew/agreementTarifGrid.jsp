<%-- <jsp:include page="includes.jsp"></jsp:include> --%>

<%@page import="com.operations.agreement.rentalclosenew.*"%>
<style>
.column{
background-color: #D6FFEA;
}
</style>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%String agmtno=request.getParameter("agmt")==null?"0":request.getParameter("agmt");
ClsRentalCloseNewDAO closedao=new ClsRentalCloseNewDAO();
String tarifnew=request.getParameter("tarifnew")==null?"":request.getParameter("tarifnew");
%>
   <jsp:include  page="..\..\..\common\commonGridNew.jsp"></jsp:include> 
<script type="text/javascript">
var agmtdata;
var tarifnew='<%=tarifnew%>';
     $(document).ready(function () { 	
    	 if(document.getElementById("agreementno").value!=''){
    			//alert("inheree");
    		      agmtdata='<%=closedao.getAgmtTarifData(agmtno,tarifnew)%>';  
    		    // alert(agmtdata);
    		      }
    	 else{
    		 
    		 agmtdata;
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
									{name : 'oinschg' , type:'number'},
									{name : 'slabfromday',type:'number'},
					              	{name : 'slabtoday',type:'number'},
					              	{name : 'slabrateperday',type:'number'},
					              	{name : 'packageblockday',type:'number'},
					              	{name : 'packageblocktarif',type:'number'},
					              	{name : 'packageextradaytarif',type:'number'}
                 ],
                localdata: agmtdata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            $('#tarifagmtgrid').on('bindingcomplete', function (event) {
            	
            	 	ShowColumns(tarifnew,"tarifagmtgrid");
            	  
            	});
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#tarifagmtgrid").jqxGrid(
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
                editable:false,
                //Add row method
                columns: [
{ text: '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype',editable:false,cellclassname:'column'},
{ text: '      '+document.getElementById("mainslabfromday").value,     datafield: 'slabfromday',editable:false,cellclassname:'column'},
{ text: '      '+document.getElementById("mainslabtoday").value,        datafield: 'slabtoday',editable:false,cellclassname:'column'},
{ text: '      '+document.getElementById("mainslabrateperday").value,        datafield: 'slabrateperday',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '      '+document.getElementById("mainpackageblockday").value,     	 datafield: 'packageblockday',editable:false,cellclassname:'column'},
{ text: '      '+document.getElementById("mainpackageblocktarif").value,    	 datafield: 'packageblocktarif',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '      '+document.getElementById("mainpackageextradaytarif").value,    	 datafield: 'packageextradaytarif',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("maincdw").value,  datafield: 'cdw',renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("mainpai").value,  datafield: 'pai',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("maincdw1").value,  datafield: 'cdw1' ,editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: '     '+document.getElementById("mainpai1").value,  datafield: 'pai1',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text:  '     '+document.getElementById("maingps").value,  datafield: 'gps', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainbabyseater").value,  datafield: 'babyseater', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("maincooler").value,  datafield: 'cooler', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainkmrest").value,  datafield: 'kmrest',  editable:true,renderer: columnsrenderer,cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainexkmrte").value,  datafield: 'exkmrte', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainoinschg").value,  datafield: 'oinschg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainexhrchg").value,  datafield: 'exhrchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
{ text: ''+document.getElementById("mainchaufexchg").value,  datafield: 'chaufexchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'}
	              ]
            });
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
            $('#tarifagmtgrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
           
            /* if(document.getElementById("agreementno").value==''){
            $("#tarifagmtgrid").jqxGrid("addrow", null, {});
            } */
            var  rows=$("#tarifagmtgrid").jqxGrid("getrows");
            if(rows.length==0){
            	$("#tarifagmtgrid").jqxGrid("addrow", null, {});
            }
            /*  $('#tarifagmtgrid').on('bindingcomplete', function (event) {
             	alert("Heree");
             	
         	    var rows = $('#tarifreferencegrid').jqxGrid('getrows');
                var rowslength=rows.length;
                //$("#tarifreferencegrid").jqxGrid('setcellvalue', rowslength, datafield, oldvalue);
         	   }); */
         	   
        	ShowColumns(tarifnew,"tarifagmtgrid");
        });
     function ShowColumns(tarifnew,gridname){
    	 if(tarifnew=="Slab"){
    		  
    		  $('#'+gridname).jqxGrid('hidecolumn', 'rate');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageblockday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageblocktarif');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageextradaytarif');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'chaufchg');
    		  $('#'+gridname).jqxGrid('showcolumn', 'slabfromday');
    		  $('#'+gridname).jqxGrid('showcolumn', 'slabtoday');
    		  $('#'+gridname).jqxGrid('showcolumn', 'slabrateperday');
    		  
    	  }
    	  else if(tarifnew=="Package"){
    		  
    		  $('#'+gridname).jqxGrid('hidecolumn', 'rate');
    		  $('#'+gridname).jqxGrid('showcolumn', 'packageblockday');
    		  $('#'+gridname).jqxGrid('showcolumn', 'packageblocktarif');
    		  $('#'+gridname).jqxGrid('showcolumn', 'packageextradaytarif');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'chaufchg');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabfromday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabtoday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabrateperday');
    		  	  
    	  }
    	  else{

    		  $('#'+gridname).jqxGrid('showcolumn', 'rate');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageblockday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageblocktarif');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'packageextradaytarif');
    		  $('#'+gridname).jqxGrid('showcolumn', 'chaufchg');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabfromday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabtoday');
    		  $('#'+gridname).jqxGrid('hidecolumn', 'slabrateperday');
    		  
    	  }
    	
    }
            </script>
            <div id="tarifagmtgrid"></div>