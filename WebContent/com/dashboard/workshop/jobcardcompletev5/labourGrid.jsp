<%@page import="com.dashboard.workshop.jobcardcompletev5.*" %>
<%ClsJobCardCompleteV5DAO gatedao=new ClsJobCardCompleteV5DAO();
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String savestatus=request.getParameter("savestatus")==null?"0":request.getParameter("savestatus");
%>
<script type="text/javascript">
var labourcostdata;
var id='<%=id%>';
if(id=="1"){
	labourcostdata='<%=gatedao.getLabourcostData(estdocno,id,savestatus)%>';
	//console.log(labourcostdata);
}
$(document).ready(function () { 
	
	var rendererstringold=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 //$('#genuinetotal').val(value.replace(/\,/g,""));
     		var labourtotal=parseFloat(value.replace(/\,/g,""));
     		$('#labourtotal').val(labourtotal);
     	}
     	var extratotal=parseFloat($('#extratotal').val());
     	var labourtotal=parseFloat($('#labourtotal').val());
 		var sparetotal=parseFloat($('#sparetotal').val());
 		var nettotal=extratotal+labourtotal+sparetotal;
 		$('#nettotal').val(nettotal);
 		funRoundAmt($('#nettotal').val(),'nettotal');
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'jobdesc', type: 'string'},
				{name : 'jobtype',type:'string'},
				{name : 'remarks',type:'string'},
				{name : 'total',type:'number'},
				{name : 'invoiceamt',type:'number'},
				{name : 'rowno',type:'string'},
				{name : 'addition',type:'number'},
				{name : 'chkcomplete',type:'bool'},
				{name : 'seccldocno',type:'string'},
				{name : 'refname',type:'string'},
				{name : 'estvocno',type:'string'},
				{name : 'estdocno',type:'string'}
          ],
          localdata: labourcostdata,
         
         
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

            
            
            $("#labourcostGrid").jqxGrid(
            {
                width: '100%',
                height: 180,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
                showstatusbar:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Est #', datafield: 'estvocno', width: '4%' ,editable:false},
							{ text: 'Addition', datafield: 'addition', width: '4%'  ,editable:false},							
							{ text: 'Job Type', datafield: 'jobtype', width: '13%' ,editable:false},
							{ text: 'Row No', datafield: 'rowno', width: '8%' ,editable:false,hidden:true},
							{ text: 'Job Desc',datafield:'jobdesc',width:'18%' ,editable:false},
							{ text: 'Remarks', datafield: 'remarks', width: '11%'  ,editable:false},
							{ text: 'Sec Cldocno', datafield: 'seccldocno', width: '20%'  ,editable:false,hidden:true},
							{ text: 'Client', datafield: 'refname', width: '20%'  ,editable:false},
							{ text: 'Total', datafield: 'total', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstringold ,editable:false},
							{ text: 'To Be Invoiced', datafield: 'invoiceamt', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:true},
							{ text: 'Completed', datafield: 'chkcomplete', width: '6%',columntype:'checkbox' ,editable:true},
			              ]
            });
           
        });
    </script>
    <div id="labourcostGrid"></div>