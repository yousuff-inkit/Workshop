<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var othersrvcdata;
var id='<%=id%>';
if(id=="1"){
	othersrvcdata='<%=bookdao.getOtherSrvcData(docno,id)%>';
}
$(document).ready(function () { 
	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         };

       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'detaildocno',type:'int'},
                       	{name : 'docname' , type:'string'},
                       	{name : 'airport' , type:'string'},
                       	{name : 'airportid',type:'int'},
                       	{name : 'greetdate' , type:'date'},
                       	{name : 'greettime',type:'date'},
                       	{name : 'greettarifdocno',type:'int'},
                       	{name : 'greettarif',type:'number'},
                       	{name : 'vipdate' , type:'date'},
                       	{name : 'viptime',type:'date'},
                       	{name : 'viptarifdocno',type:'int'},
                       	{name : 'viptarif',type:'number'},
                       	{name : 'boquedate' , type:'date'},
                       	{name : 'boquetime',type:'date'},
                       	{name : 'boquetarifdocno',type:'int'},
                       	{name : 'boquetarif',type:'number'},
                       	{name : 'greeterrorstatus',type:'number'},
                       	{name : 'viperrorstatus',type:'number'},
                       	{name : 'boqueerrorstatus',type:'number'},
     				   ],
					localdata:othersrvcdata,
                
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
            
            $("#otherSrvcGrid").jqxGrid(
            {
               width: '100%',
               height: 150,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
               enabletooltips:true,
               showaggregates:true,
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
				
				var cell=$('#otherSrvcGrid').jqxGrid('getselectedcell');
				var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
				var dataField=cell.datafield;
				var rowBoundIndex=cell.rowindex;
				if(key==114){
					if(dataField=="airport"){
	     		    	document.getElementById("othersrvcrowindex").value=rowBoundIndex;
	     		    	$('#airportwindow').jqxWindow('open');
	 					$('#airportwindow').jqxWindow('focus');
	 					airportSearchContent('airportSearchGrid.jsp?datafield='+dataField+'&gridname=otherSrvcGrid&gridrowindex='+document.getElementById("othersrvcrowindex").value, $('#airportwindow'));
	
	     		    }
	     		    else if(dataField=="greettarifdocno" || dataField=="viptarifdocno" || dataField=="boquetarifdocno"){
	     		    	if($('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')=="" || $('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')=="undefined" || $('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')==null || typeof($('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport'))=="undefined"){
	     		    		document.getElementById("errormsg").innerText="";
	     		    		document.getElementById("errormsg").innerText="Please select a valid airport";
	     		    		return false;
	     		    	}
	     		    	else{
	     		    		document.getElementById("othersrvcrowindex").value=rowBoundIndex;
	         		    	$('#srvctarifwindow').jqxWindow('open');
	     					$('#srvctarifwindow').jqxWindow('focus');
	     					srvctarifSearchContent('srvcTarifSearchGrid.jsp?datafield='+dataField+'&airportid='+$('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airportid')+'&gridname=otherSrvcGrid&gridrowindex='+document.getElementById("othersrvcrowindex").value, $('#srvctarifwindow'));
	
	     		    	}
	     		    	
	     		    }
				}
               },
            
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',editable:false,width:'20%',hidden:true},
							{ text: 'Detail Doc No', datafield: 'detaildocno',editable:false,width:'20%',hidden:true},
							{ text: '',  datafield: 'docname',editable:false,width:'4%'},
							{ text: 'Airport',  datafield: 'airport',width:'23%',editable:false},
							{ text: 'Airport ID',  datafield: 'airportid',width:'12%',editable:false ,hidden:true,renderer: columnsrenderer},
							{ text: 'Date',  datafield: 'greetdate',editable:true ,width:'7%',cellsformat:'dd.MM.yyyy',cellclassname:'column',columngroup:'greet',
								validation:function(cell,value){
									if(value==null){
										return true;
									}
									var currentdate=new Date();
									currentdate.setHours(0,0,0,0);
									value.setHours(0,0,0,0);
									var currenttextdate=currentdate.getDate()+"."+(currentdate.getMonth()+1)+"."+currentdate.getFullYear();
									if(value<currentdate){
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'greeterrorstatus',1);
										/* return { result: false, message: "Pickup Date should not be before "+currenttextdate }; */
										$("#otherSrvcGrid").jqxGrid('showvalidationpopup', cell.row, "greetdate", "Date should not be before "+currenttextdate);
										return false;
									}
									else{
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'greeterrorstatus',0);
										$('#otherSrvcGrid').jqxGrid('hidevalidationpopups');
										return true;
									}
								}
								,columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Time',  datafield: 'greettime',width:'5%',editable:true,columngroup:'greet',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Tarif Doc No',  datafield: 'greettarifdocno',columngroup:'greet',width:'5%',editable:false},
							{ text: 'Tarif Rate',  datafield: 'greettarif',columngroup:'greet',width:'7%',editable:false ,renderer: columnsrenderer},
							{ text: 'Date',  datafield: 'vipdate',editable:true ,width:'7%',cellsformat:'dd.MM.yyyy',cellclassname:'column',columngroup:'vip',
								validation:function(cell,value){
									if(value==null){
										return true;
									}
									var currentdate=new Date();
									currentdate.setHours(0,0,0,0);
									value.setHours(0,0,0,0);
									var currenttextdate=currentdate.getDate()+"."+(currentdate.getMonth()+1)+"."+currentdate.getFullYear();
									if(value<currentdate){
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'viperrorstatus',1);
										/* return { result: false, message: "Pickup Date should not be before "+currenttextdate }; */
										$("#otherSrvcGrid").jqxGrid('showvalidationpopup', cell.row, "vipdate", "Date should not be before "+currenttextdate);
										return false;
									}
									else{
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'viperrorstatus',0);
										$('#otherSrvcGrid').jqxGrid('hidevalidationpopups');
										return true;
									}
								}
								,columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Time',  datafield: 'viptime',width:'5%',columngroup:'vip',editable:true,cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Tarif Doc No',  datafield: 'viptarifdocno',columngroup:'vip',width:'5%',editable:false},
							{ text: 'Tarif Rate',  datafield: 'viptarif',width:'8%',columngroup:'vip',editable:false ,renderer: columnsrenderer},
							{ text: 'Date',  datafield: 'boquedate',editable:true ,width:'7%',cellsformat:'dd.MM.yyyy',cellclassname:'column',columngroup:'boque',
								validation:function(cell,value){
									if(value==null){
										return true;
									}
									var currentdate=new Date();
									currentdate.setHours(0,0,0,0);
									value.setHours(0,0,0,0);
									var currenttextdate=currentdate.getDate()+"."+(currentdate.getMonth()+1)+"."+currentdate.getFullYear();
									if(value<currentdate){
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'boqueerrorstatus',1);
										/* return { result: false, message: "Pickup Date should not be before "+currenttextdate }; */
										$("#otherSrvcGrid").jqxGrid('showvalidationpopup', cell.row, "boquedate", "Date should not be before "+currenttextdate);
										return false;
									}
									else{
										$('#otherSrvcGrid').jqxGrid('setcellvalue',cell.row,'boqueerrorstatus',0);
										$('#otherSrvcGrid').jqxGrid('hidevalidationpopups');
										return true;
									}
								}
								,columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true});
 						    }},
							{ text: 'Time',  datafield: 'boquetime',width:'5%',editable:true,columngroup:'boque',cellsformat:'HH:mm',cellclassname:'column',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Tarif Doc No',  datafield: 'boquetarifdocno',columngroup:'boque',width:'5%',editable:false},
							{ text: 'Tarif Rate',  datafield: 'boquetarif',width:'7%',columngroup:'boque',editable:false ,renderer: columnsrenderer},
							{ text: 'Error Status',datafield:'greeterrorstatus',aggregates: ['sum'],hidden:true},
							{ text: 'Error Status',datafield:'viperrorstatus',aggregates: ['sum'],hidden:true},
							{ text: 'Error Status',datafield:'boqueerrorstatus',aggregates: ['sum'],hidden:true}
         	              ], columngroups: 
     	                     [
   	                       { text: 'Greet and Meet', align: 'center', name: 'greet',width:10 },
   	                    { text: 'VIP', align: 'center', name: 'vip',width:10 },
   	                 { text: 'Boque', align: 'center', name: 'boque',width:10 }
						
   	                    
   	                     ]
           
            });
            
            $("#otherSrvcGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		    
            		    if(dataField=="airport"){
            		    	document.getElementById("othersrvcrowindex").value=rowBoundIndex;
            		    	$('#airportwindow').jqxWindow('open');
        					$('#airportwindow').jqxWindow('focus');
        					airportSearchContent('airportSearchGrid.jsp?datafield='+dataField+'&gridname=otherSrvcGrid&gridrowindex='+document.getElementById("othersrvcrowindex").value, $('#airportwindow'));

            		    }
            		    else if(dataField=="greettarifdocno" || dataField=="viptarifdocno" || dataField=="boquetarifdocno"){
            		    	if($('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')=="" || $('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')=="undefined" || $('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport')==null || typeof($('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airport'))=="undefined"){
            		    		document.getElementById("errormsg").innerText="";
            		    		document.getElementById("errormsg").innerText="Please select a valid airport";
            		    		return false;
            		    	}
            		    	else{
            		    		document.getElementById("othersrvcrowindex").value=rowBoundIndex;
                		    	$('#srvctarifwindow').jqxWindow('open');
            					$('#srvctarifwindow').jqxWindow('focus');
            					srvctarifSearchContent('srvcTarifSearchGrid.jsp?datafield='+dataField+'&airportid='+$('#otherSrvcGrid').jqxGrid('getcellvalue',rowBoundIndex,'airportid')+'&gridname=otherSrvcGrid&gridrowindex='+document.getElementById("othersrvcrowindex").value, $('#srvctarifwindow'));
	
            		    	}
            		    	
            		    }
            		});                       
            		      
});

	
            </script>
            <div id="otherSrvcGrid"></div>
<input type="hidden" name="othersrvcrowindex" id="othersrvcrowindex">