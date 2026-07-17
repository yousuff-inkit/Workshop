<%@page import="com.dashboard.limousine.jobclose.*" %>
<%ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();

String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var calcdata;
if(id=="1"){
	
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [
						{name : 'jobname',type:'string'},
						{name : 'bookdocno',type:'int'},
						{name : 'jobdocno',type:'int'},
						{name : 'tarifdocno',type:'int'},
						{name : 'tarifdetaildocno',type:'int'},
                       	{name : 'startdate' , type: 'date' },
                       	{name : 'starttime',type:'string'},
                       	{name : 'startkm',type:'number'},
                       	{name : 'enddate',type:'date'},
                       	{name : 'endtime' , type:'string'},
                       	{name : 'endkm',type:'number'},
                       	{name : 'fuelchg',type:'number'},
                       	{name : 'parkingchg',type:'number'},
                       	{name : 'otherchg',type:'number'},
                       	{name : 'greetchg',type:'number'},
                       	{name : 'vipchg',type:'number'},
                       	{name : 'boquechg',type:'number'}
     				   ],
					localdata:calcdata,
                
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

            $("#calculationGrid").jqxGrid(
            {
               width: '99%',
               height: 150,
               source: dataAdapter,
               columnsresize: true,
               editable:true,
               selectionmode: 'singlecell',
               columnsheight: 20,
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
                       
							{ text: 'Job Name',datafield:'jobname',width:'6%',hidden:true},
							{ text: 'Job Name',datafield:'jobnametemp',width:'6%',cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
								var bookdocno=$('#calculationGrid').jqxGrid('getcellvalue',row,'bookdocno');
								var jobname=$('#calculationGrid').jqxGrid('getcellvalue',row,'jobname');
					        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+jobname) + "</div>";
					    	}},
							{ text: 'Book Doc No',datafield:'bookdocno',hidden:true},
							{ text: 'Job Doc No',datafield:'jobdocno',hidden:true},
							{ text: 'Tarif Detail Doc No',datafield:'tarifdetaildocno',hidden:true},
							{ text: 'tarif Doc No',datafield:'tarifdocno',hidden:true},
							{ text: 'Start Date',datafield:'startdate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'startdetails',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true });
 						    }},
							{ text: 'Start Time',datafield:'starttime',width:'7%',cellsformat:'HH:mm',columngroup:'startdetails',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'Start Km',datafield:'startkm',width:'8%',cellsformat:'d2',columngroup:'startdetails'},
							{ text: 'End Date',datafield:'enddate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'enddetails',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: true });
 						    }},
							{ text: 'End Time',datafield:'endtime',width:'7%',cellsformat:'HH:mm',columngroup:'enddetails',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
 						        editor.jqxDateTimeInput({ showCalendarButton: false });
 						    }},
							{ text: 'End Km',datafield:'endkm',width:'8%',cellsformat:'d2',columngroup:'enddetails'},
							{ text: 'Fuel Charge',datafield:'fuelchg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right'},
							{ text: 'Parking Charge',datafield:'parkingchg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right'},
							{ text: 'Other Charge',datafield:'otherchg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right'},
							{ text: 'Greet And Meet',datafield:'greetchg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right',editable:false},
							{ text: 'VIP',datafield:'vipchg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right',editable:false},
							{ text: 'Boque',datafield:'boquechg',width:'8%',cellsformat:'d2',columngroup:'charges',align:'right',cellsalign:'right',editable:false}
							
         	              ], columngroups: 
     	                     [
   	                       	{ text: 'Start Details', align: 'center', name: 'startdetails',width:10 },
   	                    	{ text: 'End Details', align: 'center', name: 'enddetails',width:10 },
   	                    	{ text: 'Charges', align: 'center', name: 'charges',width:10 }
   	                    
   	                     ]
           
            });
            
            $('#calculationGrid').on('rowselect', function (event) 
            		{
  		    // event arguments.
  		    var args = event.args;
  		    // row's bound index.
  		    var rowBoundIndex = event.args.rowindex;
  		    // row's data. The row's data object or null(when all rows are being sele cted or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
  		    var rowData = event.args.row;
  		    
            });
            
            

            $("#calculationGrid").on('cellvaluechanged', function (event) 
            {
                // event arguments.
                var args = event.args;
                // column data field.
                var dataField = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = event.args.rowindex;
                // cell value
                var value = event.args.value;
                // cell old value.
                var oldvalue = event.args.oldvalue;
                // row's data.
                var rowData = event.args.row;
                $('#amountGrid').jqxGrid('clear');
                var startdate=new Date($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'startdate'));
            	var enddate=new Date($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'enddate'));
            	startdate.setHours(0,0,0,0);
            	enddate.setHours(0,0,0,0);
            	var starttime=new Date($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'starttime'));
            	var endtime=new Date($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'endtime'));
            	var startkm=parseFloat($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'startkm'));
            	var endkm=parseFloat($('#calculationGrid').jqxGrid('getcellvalue',rowBoundIndex,'endkm'));
            
                if(dataField=="enddate"){
                	if(enddate<startdate){
                		$.messager.alert('warning','End date cannot be less than start date');
                		$("#calculationGrid").jqxGrid('begincelledit', rowBoundIndex, "enddate");
                		return false;
                	}
                }
                
                else if(dataField=="endtime"){
                	if(startdate-enddate==0){
                		if(endtime.getHours()<starttime.getHours()){
                			$.messager.alert('warning','End time cannot be less than start time');
                    		$("#calculationGrid").jqxGrid('begincelledit', rowBoundIndex, "endtime");
                    		return false;
                		}
                		else if(endtime.getHours==starttime.getHours()){
                			if(endtime.getMinutes()<starttime.getMinutes()){
                				$.messager.alert('warning','End time cannot be less than start time');
                        		$("#calculationGrid").jqxGrid('begincelledit', rowBoundIndex, "endtime");	
                        		return false;
                			}
                		}
                	}
                }
                
                else if(dataField=="endkm"){
                	if(endkm<startkm){
                		$.messager.alert('warning','End km cannot be less than start km');
                		$("#calculationGrid").jqxGrid('begincelledit', rowBoundIndex, "endkm");	
                		return false;
                	}
                }
            });
            
            
            
            });

	
            </script>
            <div id="calculationGrid"></div>
			<input type="hidden" name="calcrowindex" id="calcrowindex">