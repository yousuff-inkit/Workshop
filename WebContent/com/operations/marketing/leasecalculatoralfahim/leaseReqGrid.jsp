<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralfahim.*" %>
<% String contextPath=request.getContextPath();%>
<%ClsLeaseCalcAlFahimDAO calcdao1=new ClsLeaseCalcAlFahimDAO(); %>
<%String reqdocno=request.getParameter("reqdocno")==null?"0":request.getParameter("reqdocno");%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");%>
<style>
.focusClass{
	background-color:#5ae1b5;
}
</style>
<script type="text/javascript">
		var reqdocno='<%=reqdocno%>';
		var reqdata;
		//alert(reqdocno);
		if(reqdocno!="0" && reqdocno!=""){
			reqdata='<%=calcdao1.getReqData(reqdocno,id,docno)%>';
		}
		else{
			
		}
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'leasefromdate', type: 'date' }, 
     						{name : 'brand', type: 'string'   },
     						{name : 'model', type: 'string'  },
     						{name : 'specification', type: 'string'   },
     						{name : 'color', type: 'string'   },
     						{name : 'leasemonths', type: 'number' },
     						{name : 'kmpermonth',type:'number'},
     						{name : 'gname',type:'string'},

							{name : 'quotbtn', type: 'String'  },
							{name : 'qty',type:'number'},
     						{name : 'brdid',type:'number'},
     						{name : 'modelid',type:'number'},
     						{name : 'clrid',type:'number'},
     						{name : 'grpid',type:'number'},
     						{name : 'rowcolor',type:'number'},
     						{name : 'srno',type:'number'},
     						{name :'dealer',type:'string'},
     						{name : 'hiddealer',type:'string'},
     						{name :'purchcost',type:'number'},
     						{name : 'downpytper',type:'number'},
     						{name : 'interestper',type:'number'},
     						{name : 'creditcardper',type:'number'},
     						{name : 'authority',type:'string'},
     						{name : 'hidauthority',type:'string'},
     						{name : 'authid',type:'string'},
     						{name : 'profitper',type:'number'},
     						{name : 'overheadper',type:'number'},
     						{name : 'others',type:'number'},
     						{name : 'discount',type:'number'},
     						{name :'savestatus',type:'int'},
     						{name : 'totalvalue',type:'number'},
     						{name : 'confirmstatus',type:'int'},
     						{name : 'reqsrno',type:'number'},
     						{name : 'yom',type:'string'},
     						{name : 'yomid',type:'string'},
     						{name : 'vsb',type:'string'}
     						
     						
                        ],
                         localdata: reqdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname = function (row, column, value, data) {
                if(data.rowcolor=="1"){
                	return "focusClass";
                }
                else{
                	
                }
                  };
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaseReqGrid").jqxGrid(
            {
                width: '98%',
                height: 130,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	/* var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    } */ 
                },
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{ text: 'Lease From', datafield: 'leasefromdate',  width: '8%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },	
							{ text: 'Brand', datafield: 'brand', width: '10%',cellclassname:cellclassname},	
							{ text: 'Model', datafield: 'model',  width: '16%' ,cellclassname:cellclassname},
							{ text: 'Specification', datafield: 'specification', width: '18%' ,cellclassname:cellclassname,hidden:true},
							{ text: 'Yom',datafield:'yom',width:'9%',cellclassname:cellclassname},
							{ text: 'Yom Id',datafield:'yomid',width:'9%',cellclassname:cellclassname,hidden:true},
							{ text: 'Color', datafield: 'color', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Lease in Months', datafield: 'leasemonths', width: '7%' ,cellclassname:cellclassname},
							{ text: 'KM use', datafield: 'kmpermonth', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Group', datafield: 'gname', width: '7%' ,cellclassname:cellclassname},
							{ text: 'VSB',datafield:'vsb',width:'9%',cellclassname:cellclassname},
							{ text: 'Total', datafield: 'totalvalue', width: '10%' ,align:'right',cellsalign:'right',cellclassname:cellclassname,cellsformat:'d2'},

							{ text: ' ', datafield: 'quotbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
							{ text: 'Quantity',datafield:'qty',width:'6%',hidden:true},
							{ text: 'Brand Id',datafield:'brdid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'model Id',datafield:'modelid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Color Id',datafield:'clrid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Group Id',datafield:'grpid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Srno',datafield:'srno',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Dealer',datafield:'dealer',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Dealer Docno',datafield:'hiddealer',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Purchase Cost',datafield:'purchcost',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Down Payment %',datafield:'downpytper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Interest %',datafield:'interestper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Credit Card %',datafield:'creditcardper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Name',datafield:'authority',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Doc No',datafield:'hidauthority',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Code',datafield:'authid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Profit %',datafield:'profitper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Over Head %',datafield:'overheadper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Others',datafield:'others',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Discount',datafield:'discount',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Save Status',datafield:'savestatus',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Confirm Status',datafield:'confirmstatus',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Req Srno',datafield:'reqsrno',width:'10%',hidden:true,cellclassname:cellclassname}
						]
            });




		 $('#leaseReqGrid').on('cellclick', function (event) 
            		{ 
             
           var data=event.args.datafield;
		   if(data=="quotbtn"){
            	// alert("===="+event.args.rowindex);
    			var value = $('#leaseReqGrid').jqxGrid('getcelltext', event.args.rowindex, "quotbtn");
    			// alert("=== "+value);
    			
    			if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
      		  	  
     		  	   var url=document.URL;
			 //alert(url);
			var reurl=url.split("com/");
			 // alert(reurl[0]);       
			         $("#docno").prop("disabled", false);
			/* var win= window.open(reurl[0]+"com/operations/marketing/leasecalculatoralfahim/printcalQuot?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		      
			 win.focus(); */
			         var win= window.open(reurl[0]+"com/operations/marketing/leasecalculatoralfahim/JasperprintLeaseCalculator?docno="+document.getElementById("docno").value+"&print=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
			 
			
    			}
    			}
            		});




            
            $('#leaseReqGrid').on('celldoubleclick', function (event) 
            		{ 
            			var rows=$('#leaseReqGrid').jqxGrid('getrows');
            			for(var i=0;i<rows.length;i++){
            				$('#leaseReqGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
            			}
            			var rowindex1=event.args.rowindex;
            			document.getElementById("reqsrno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'reqsrno');
            			if(document.getElementById("docno").value!=""){
                			document.getElementById("lblvehicle").innerText="";
                			document.getElementById("lblvehicle").innerText=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'brand')+" "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'model')+" Group "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'gname');
                			document.getElementById("kmuse").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
                			$('#leaseReqGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');            				
            				
            			}
            			if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus')=="1"){
            				$('#leasetypeonediv').load('leaseTypeoneGrid.jsp?id=5&reqdocno='+$('#hidleasereqdoc').val()+'&reqsrno='+$('#reqsrno').val()+'&calcdocno='+$('#docno').val());
            			  	$('#leasetypetwodiv').load('leaseTypetwoGrid.jsp?id=5&reqdocno='+$('#hidleasereqdoc').val()+'&reqsrno='+$('#reqsrno').val()+'&calcdocno='+$('#docno').val());
            				//$('#btnprocess,#btnprocesssave').attr('disabled',true);	
            			}
            			else{
            				$('#leaseTypeoneGrid').jqxGrid('clear');
            				$('#leaseTypetwoGrid').jqxGrid('clear');
            				$('#leasetypeonediv').load('leaseTypeoneGrid.jsp?id=1&reqdocno='+$('#hidleasereqdoc').val()+'&reqsrno='+$('#reqsrno').val());
            				//$('#processfield').attr('disabled',false);
            				//$('#btnprocess,#btnprocesssave').attr('disabled',false);
            			}
            			//$('#processfield').attr('disabled',false);
            			
						if($('#docno').val()!=""){
                    		var x=new XMLHttpRequest();
            		        x.onreadystatechange=function(){
            		        	if (x.readyState==4 && x.status==200) 	 
            		         	{
            		        		var items= x.responseText.trim();
            		        		
            		        		if(items=="0"){
            		        			$('#btnprocess,#btnprocesssave').attr('disabled',false);
            		        			$('#processfield').attr('disabled',false);
            		        		}
            		        		else{
            		        			$('#btnprocess,#btnprocesssave').attr('disabled',true);
            		        			$('#processfield').attr('disabled',true);
            		        		}
            		         	}
            		        }
            		        x.open("GET","checkEditOption.jsp?docno="+$('#docno').val(),true);
            		      	x.send();        			
                		}
						
						
						
						/* if(document.getElementById("mode").value=="A"){
            				return false;
            			}
						var data=event.args.datafield;
						if(data!="quotbtn"){
		            	var rowindex1=event.args.rowindex;
						var rows=$('#leaseReqGrid').jqxGrid('getrows');
						for(var i=0;i<rows.length;i++){
							$('#leaseReqGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
						}
						$('#leaseReqGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
						document.getElementById("lblvehicle").innerText=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'brand')+" "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'model')+" Group "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'gname');
						document.getElementById("savestatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus');
						document.getElementById("confirmstatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus');
						document.getElementById("leasemonths").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
						document.getElementById("kmpermonth").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
						document.getElementById("grpid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'grpid');
						document.getElementById("srno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
						
						if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus')=="1" && $('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="0"){
							document.getElementById("btnconfirm").style.display="block";
						}
						else{
							document.getElementById("btnconfirm").style.display="none";
						}
						if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="1"){
							document.getElementById("btnleaseedit").disabled=true;
						}
						} */
            		}); 
        
            
            //Add empty row
         	 /* $("#jqxleasecalculator").jqxGrid('addrow', null, {}); */
         	            
        });
    </script>
    <div id="leaseReqGrid"></div>
    
