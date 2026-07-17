<%@page import="com.operations.agreement.leaseagreement.*" %>
<%
ClsLeaseAgreementDAO agmtdao= new ClsLeaseAgreementDAO();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>
<script type="text/javascript">
var kmdata=[];
var id='<%=id%>';
if(id=="1"){
	kmdata='<%=agmtdao.getKmDetails(docno,id)%>';
}
        $(document).ready(function () {
        	
       
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;text-align:right;">' + " " + '' + value + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no' , type: 'string' },
							{name : 'reg_no' , type:'string'},
							{name : 'flname' , type:'string'},
							{name : 'dout',type:'date'},
							{name : 'tout',type:'date'},
							{name : 'kmout' , type:'number'},
							{name : 'kmin',type:'number'},
							{name : 'din',type:'date'},
							{name : 'tin',type:'tin'},
							{name : 'kmdiff' , type:'number'},
							
	                      ],
                          localdata: kmdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
       
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#kmDetailsGrid").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
              	rowsheight:25,
             	statusbarheight:25, 
                editable: false,
              
                //Add row method
                columns: [   
							{ text: 'Fleet No', datafield: 'fleet_no', width: '8%' },
							{ text: 'Reg No',  datafield: 'reg_no', width: '8%' },
							{ text: 'Fleet Name',  datafield: 'flname', width: '28%'},
							{ text: 'Date Out',datafield:'dout',width:'8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Time Out',datafield:'tout',width:'7%',cellsformat:'HH:mm'},
							{ text: 'Km Out',  datafield: 'kmout', width: '8%',cellsformat:'d',align:'right',cellsalign:'right'},
							{ text: 'Date In',datafield:'din',width:'8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Time In',datafield:'tin',width:'7%',cellsformat:'HH:mm'},
							{ text: 'Km In',  datafield: 'kmin', width: '8%' ,cellsformat:'d',align:'right',cellsalign:'right'},
							{ text: 'Total Used Km', datafield:'kmdiff',  width:'10%',cellsformat:'d',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
											 ]
            });
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#kmDetailsGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#kmDetailsGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       
                   }
                   else {
                	  
                   }
               });
               $("#kmDetailsGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#kmDetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                       var rowindex=event.args.rowindex;
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
               });

       		$('#btnkmprint').click(function(){
       			var url=document.URL;
       			var reurl=url.split("saveLeaseAgreement");
       			var docno='<%=docno%>';
       			var win= window.open(reurl[0]+"printKmDetailsLease?docno="+docno,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
			 	win.focus();
       		});
        });

</script>
<div style="text-align:right;margin-right:10px;margin-bottom:5px;"><button type="button" name="btnkmprint" id="btnkmprint" class="myButton" >Print</button></div>
<div id='jqxWidget'>
	<div id="kmDetailsGrid"></div>
    <div id="popupWindow">
		<div id='Menu'>
        	<ul>
            	<li>Print</li>
        	</ul>
       </div>
   </div>
</div>