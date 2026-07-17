<%@page import="com.limousine.limotarifmgmt.*" %>
<%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO();
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String gid=request.getParameter("gid")==null?"0":request.getParameter("gid");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var datahours;
var id='<%=id%>';
if(id=="1"){
	datahours='<%=tarifdao.getTarifHours(id,gid,docno)%>';
}
$(document).ready(function () { 

 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         }

         var num = 1; 
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'blockhrs' , type: 'number' },
                       	{name : 'limotarif' , type:'number'},
                       	{name : 'exhrrate' , type:'number'},
                       	{name : 'nighttarif' , type:'number'},
                       	{name : 'nightexhrrate' , type:'number'},
                       	{name : 'exdistancerate' , type:'number'},
                       	{name : 'extimerate' , type:'number'}
     				   ],
					localdata:datahours,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
           
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
            
            $("#gridTarifHour").jqxGrid(
            {
               width: '100%',
               height: 107,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
							{ text: ''+document.getElementById("mainblockhrs").value, datafield: 'blockhrs',width:'20%'},
							{ text: ''+document.getElementById("mainlimotarif").value,  datafield: 'limotarif',width:'20%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainexhrrate").value,  datafield: 'exhrrate' ,width:'20%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainnighttarif").value,  datafield: 'nighttarif',width:'20%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'},
							{ text: ''+document.getElementById("mainnightexhrrate").value,  datafield: 'nightexhrrate',width:'20%',renderer: columnsrenderer,cellsformat: 'd2',cellsalign:'right'}
							
         	              ]
           
            });
            
            if(document.getElementById("subblockhrs").value!=""){
            	$('#gridTarifHour').jqxGrid('hidecolumn', ''+document.getElementById("subblockhrs").value);	
            }
            if(document.getElementById("sublimotarif").value!=""){
            	$('#gridTarifHour').jqxGrid('hidecolumn', ''+document.getElementById("sublimotarif").value);
            }
            if(document.getElementById("subexhrrate").value!=""){
            	$('#gridTarifHour').jqxGrid('hidecolumn', ''+document.getElementById("subexhrrate").value);	
            }
            if(document.getElementById("subnighttarif").value!=""){
            	$('#gridTarifHour').jqxGrid('hidecolumn', ''+document.getElementById("subnighttarif").value);	
            }
            if(document.getElementById("subnightexhrrate").value!=""){
            	$('#gridTarifHour').jqxGrid('hidecolumn', ''+document.getElementById("subnightexhrrate").value);	
            }
            
            $("#gridTarifHour").on("cellvaluechanged", function (event)
            		{
            		    // event arguments.
            	 // event arguments.
                var args = event.args;
                // column data field.
                var datafield = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = event.args.rowindex;
                // new cell value.
                var value = event.args.newvalue;
                // old cell value.
                var oldvalue = event.args.oldvalue;
                
                var rows=$('#gridTarifHour').jqxGrid('getrows');
                if(datafield=="blockhrs"){
                    if(rowBoundIndex==rows.length-1){
                    	$("#gridTarifHour").jqxGrid("addrow", null, {});
                    }                	
                }

            		    
            		});  
});
            </script>
            <div id="gridTarifHour"></div>