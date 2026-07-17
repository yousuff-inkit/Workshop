<%-- <<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include> --%>
<%@page import="com.dashboard.workshop.gipmgmt.*" %>
<%ClsGIPMgmtDAO floordao=new ClsGIPMgmtDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var floordata=[];
if(id=="1"){
	floordata='<%=floordao.getGIPMgmtData(id,brhid)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'branchname' , type: 'string'},
                      	{name : 'customertype',type:'string'},
 						{name : 'docno', type: 'number'},
 						{name : 'vocno', type: 'string'},
 						{name : 'date', type:'date'},
 						{name : 'time',type:'string'},
 						{name : 'refname',type:'string'},
                      	{name : 'mobile', type: 'string'  },
                      	{name : 'email',type:'string'},
                      	{name : 'repairtype',type:'string'},
                      	{name : 'processstatus',type:'string'},
                      	{name : 'estdocno',type:'string'},
                      	{name : 'jobdocno',type:'string'},
                      	{name : 'estvocno',type:'string'},
                      	{name : 'jobvocno',type:'string'},
                      	{name : 'cldocno',type:'number'},
                      	{name : 'insurcldocno',type:'number'},
                      	{name : 'gipprocess',type:'string'},
                      	{name : 'brhid',type:'string'},
                      	{name : 'fleetdetails',type:'string'},
                      	{name : 'pono',type:'string'},
                      	{name : 'chkexcess',type:'string'},
                      	{name : 'excessamt',type:'string'},
                      	{name : 'gipclientaddress',type:'string'},
                      	{name : 'gipclientmobile',type:'string'},
                      	{name : 'gipclientcat',type:'string'},
                      	{name : 'gipclienttrn',type:'string'},
                      	{name : 'chkvirtual',type:'bool'},
                      	{name : 'insurcompname',type:'string'},
                      	{name : 'estclaimno',type:'string'},
                      	{name : 'backjob',type:'number'},
                      	{name : 'policerep',type:'string'},
                      	{name : 'policerepdate',type:'date'},
                      	{name : 'regexpirydate',type:'date'},
                      	{name : 'drvlicence',type:'string'},
                      	{name : 'emiratesid',type:'string'},
                      	{name : 'colorid',type:'string'},
                      	{name : 'insutype',type:'string'},
                      	{name : 'priority',type:'string'},
                      	{name : 'estimator',type:'string'},
                      	{name : 'estimatorid',type:'string'},
                      	{name : 'serviceadvisor',type:'string'},
                      	{name : 'faulttype',type:'string'},
                      	{name : 'chklistremarks',type:'string'},
                      	{name : 'referencedby',type:'string'},
                     	{name : 'referencedbyname',type:'string'},
                     	{name : 'gipmgmtsms',type:'string'}
                      	
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#floorMgmtGrid").on("bindingcomplete", function (event) {
        
        	//Getting Filters
        	if(rawfilterdata.length>0){
        		for(let x in rawfilterdata){
        			var filteritem=rawfilterdata[x];
        			if(filteritem.filtercolumn=="gipprocess"){
        				var filtervalue = filteritem.filter.getfilters()[0].value;
	        			var filtergroup = new $.jqx.filter();
			    		var filter_or_operator = 1;
			    		var filtercondition = 'contains';
			    		var filter1 = filtergroup.createfilter("stringfilter", filtervalue, filtercondition);
						filtergroup.addfilter(filter_or_operator, filter1);
			    		
			    		$("#floorMgmtGrid").jqxGrid('addfilter', 'gipprocess', filtergroup);
			    		$("#floorMgmtGrid").jqxGrid('applyfilters');	
        			}
        			
        		}
        	}
        	$('.page-loader').hide();
        
        });
        
        var cellclassname = function (row, column, value, data) {
        	if(data.backjob=="1"){
            	return "redClass";
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 400,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Client Type',datafield: 'customertype', width: '5%',cellclassname: cellclassname},
    					{ text: 'Branch',datafield: 'branchname', width: '6%',cellclassname: cellclassname},
    					{ text: 'Doc No',datafield: 'docno', width: '5%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Doc No',datafield: 'vocno', width: '5%',cellclassname: cellclassname},
    					{ text: 'Est No', datafield: 'estvocno', width: '5%',cellclassname: cellclassname,hidden:false},
    					{ text: 'Job No', datafield: 'jobvocno', width: '5%',cellclassname: cellclassname,hidden:false},
    					{ text: 'Process',datafield: 'gipprocess', width: '7%',cellclassname: cellclassname},
    					{ text: 'Fleet',datafield: 'fleetdetails', width: '12%',cellclassname: cellclassname},
    					{ text: 'Date',datafield: 'date', width: '6%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Time', datafield: 'time', width: '4%',cellclassname: cellclassname,cellsformat:'HH:mm'},
    					{ text: 'Client',datafield: 'refname' ,cellclassname: cellclassname,width:'15%'},
    					{ text: 'Telephone', datafield: 'mobile', width: '9%',cellclassname: cellclassname},
    					{ text: 'Email', datafield: 'email', width: '9%',cellclassname: cellclassname},
    					{ text: 'Insurance Company',datafield: 'insurcompname' ,width:'9%',cellclassname: cellclassname},
    					{ text: 'Repair Type', datafield: 'repairtype', width: '7%',cellclassname: cellclassname},
    					{ text: 'Process Status', datafield: 'processstatus', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Est Doc No', datafield: 'estdocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					
    					{ text: 'Job Doc No', datafield: 'jobdocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					
    					{ text: 'Client Doc No', datafield: 'cldocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Insur Client Doc No', datafield: 'insurcldocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Branch Id', datafield: 'brhid', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Claim No', datafield: 'estclaimno', width: '10%',cellclassname: cellclassname},
    					{ text: 'PO No', datafield: 'pono', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Excess', datafield: 'chkexcess', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Excess Amount', datafield: 'excessamt', width: '10%',cellclassname: cellclassname,hidden:true,cellsformat:'d2'},
    					{ text: 'GIP Client Mobile', datafield: 'gipclientmobile', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'GIP Client Email', datafield: 'gipclientemail', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'GIP Client Category', datafield: 'gipclientcat', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'GIP Client TRN', datafield: 'gipclienttrn', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Physically Not Available', datafield: 'chkvirtual', width: '4%',cellclassname: cellclassname,columntype:'checkbox'},
						{ text: 'Back Job', datafield: 'backjob', width: '4%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Policerepdate',datafield: 'policerepdate', width: '6%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Reg.Exp.Date',datafield: 'regexpirydate', width: '6%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
						{ text: 'policerep', datafield: 'policerep', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'drvlicence', datafield: 'drvlicence', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'emiratesid', datafield: 'emiratesid', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'colorid', datafield: 'colorid', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'insutype', datafield: 'insutype', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'priority', datafield: 'priority', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'Estimator', datafield: 'estimator', width: '6%',cellclassname: cellclassname},
						{ text: 'estimatorid', datafield: 'estimatorid', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'Serviceadvisor', datafield: 'serviceadvisor', width: '10%',cellclassname: cellclassname},
						{ text: 'faulttype', datafield: 'faulttype', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'chklistremarks', datafield: 'chklistremarks', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'referencedby', datafield: 'referencedby', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'referencedbyname', datafield: 'referencedbyname', width: '4%',cellclassname: cellclassname,hidden:true},
						{ text: 'GIPMGMT SMS', datafield: 'gipmgmtsms', width: '4%',cellclassname: cellclassname,hidden:false},

						
    	              ]
                });
				
				$('#floorMgmtGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = event.args.rowindex;
				    // row's visible index.
				    var visibleIndex = event.args.visibleindex;
				    // right click.
				    var rightclick = event.args.rightclick; 
				    // original event.
				    var ev = event.args.originalEvent;
				    
				 	$('#rowindex').val(boundIndex);
				 	var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno');
				 	$('#docno').val(docno);
			        getfileattachConfig(docno);
				 	$('#estdocno,#refno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estdocno'));
				 	$('#gatedocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno'));
				 	var gatebrhid=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid');
				 	$('#branch').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
					$('#checklistdiv').load('checklistGrid.jsp?gatedocno='+$('#gatedocno').val());

				 	var vocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'vocno');
				 	$('.gipvocno').text(vocno);
				 	var refname=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'refname');
				 	var cldocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'cldocno');
				 	var insurcldocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'insurcldocno');
				 	$('#qotpono,#qotdesc,#qotexcessamt,#createclientname,#createclientmobile,#createclientemail,#createclientaddress,#createclienttrno').val('');
				 	$('#cmbcreateclientcat').val(null).trigger('change');
				 	$('#createclientname').val(refname);
				 	$('#createclientmobile').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gipclientmobile'));
				 	$('#createclientemail').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'email'));
				 	$('#createclientaddress').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gipclientaddress'));
				 	$('#createclienttrn').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gipclienttrn'));
				 	
				 	$('#policereportno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'policerep'));
				 	$('#hidcmbdrvlicence').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'drvlicence'));
				 	$('#hidcmbemiratesid').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'emiratesid'));
				 	$('#hidcmbcolor').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'colorid'));
				 	$('#hidcmbclaimtype').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'faulttype'));
				 	$('#hidcmbpriority').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'priority'));
				 	$('#hidmarketingperson').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estimatorid'));
				 	$('#marketingperson').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estimator'));
				 	$('#hidcmbinstype').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'insutype'));
				 	$('#chklistremarks').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'chklistremarks'));
				 	$('#hidreferencedby').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'referencedby'));
				 	$('#referencedby').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'referencedbyname'));

					$('#policereportdate').jqxDateTimeInput('setDate',$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, "policerepdate"));
	                $('#regexpirydate').jqxDateTimeInput('setDate',$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, "regexpirydate"));
	                setValues();

				 	
				 	var catid=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gipclientcat');
				 	$('#cmbcreateclientcat').val(catid).trigger('change');
				 	var virtual=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'chkvirtual');
				 	if(virtual==true){
				 		$('#cmbvirtual').val(1).trigger('change');	
				 	}
				 	else{
				 		$('#cmbvirtual').val(0).trigger('change');
				 	}
				 	
				 	//$('#createclientname,#createclientmobile,#createclientemail').attr('readonly',true);
				 	document.getElementById("chkqotexcess").checked=false;
				 	$('#qotpono').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'pono'));
				 	document.getElementById("qotexcessamt").disabled=true;
				 	if($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'chkexcess')=='1'){
				 		document.getElementById("chkqotexcess").checked=true;
				 		document.getElementById("qotexcessamt").value=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'excessamt');
				 		document.getElementById("qotexcessamt").disabled=false;
				 	}
				 	else{
				 		document.getElementById("chkqotexcess").checked=false;
				 		document.getElementById("qotexcessamt").value='';
				 		document.getElementById("qotexcessamt").disabled=true;
				 	}
				 	if(parseInt(cldocno)>0){
				 		$('#cmbbilltoclient').val(cldocno).trigger('change');
				 	}
				 	if(parseInt(insurcldocno)>0){
				 		$('#cmbbilltoinsur').val(insurcldocno).trigger('change');
				 	}
				 	$('.textpanel p').text(vocno+' - '+refname);
					
				 	if($('#smsconfig').val()=='1'){
				 		var gipmgmtsms=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gipmgmtsms');
				 		if(gipmgmtsms=="1"){
				 			$('#btnsms').attr('disabled',true);
				 			$('#btnsms').addClass('disabled');
				 		}
				 		else{
				 			$('#btnsms').attr('disabled',false);
				 			$('#btnsms').removeClass('disabled');
				 			getSMSData(docno,gatebrhid);
				 		}
				 		
				 	}
					var htmldata='';
					var dividerstatus=0;
					$.get('getEstAddCount.jsp',
						{
							estdocno:$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estdocno'),
							brhid:$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid')
						},
						function(data){
							data=JSON.parse(data);
							$.each(data.estcountdata,function(index,value){
								if(index=="0"){
									htmldata+='<li role="presentation" data-addition="0"><a href="#">Estimation</a></li>';
								}
								else{
									if(dividerstatus=="0"){
										htmldata+='<li role="presentation" class="divider"></li>';
										dividerstatus=1;	
									}
									htmldata+='<li role="presentation" data-addition="'+value+'"><a href="#">Add.Estimation '+value+'</a></li>';
								}
							});
							$('.otherpanel .dropdown .dropdown-menu').html($.parseHTML(htmldata));	
							$('.otherpanel .dropdown .dropdown-menu li').click(function(index,value){
								var addition=$(this).attr('data-addition');
								if(addition=="0"){
									var url=document.URL;
									var reurl=url.split("com/");
									var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estdocno');
									var estvocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estvocno');
									var gatedoc=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno');
									var brhid=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid');
									window.parent.formName.value="Estimation";
								  	window.parent.formCode.value="EST";
								  	var detName="Estimation";
								  	var path= window.estimationaction+"?id=2&mode=view&docno="+docno+"&gipnoo="+gatedoc;
								 	top.addTab( detName,reurl[0]+""+path);
								}
								else{
									var url=document.URL;
									var reurl=url.split("com/");
									var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estdocno');
									var jobdocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'jobdocno');
									var estvocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'estvocno');
									var gatedoc=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno');
									var brhid=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid');
									window.parent.formName.value="Additional Estimation";
								  	window.parent.formCode.value="WAE";
								  	var detName="Additional Estimation";
								  	var path= window.estimationaddaction+"?id=2&mode=view&docno="+docno+"&gipnoo="+gatedoc+"&addition="+addition+"&brhid="+brhid+"&jcno="+jobdocno;
								 	top.addTab( detName,reurl[0]+""+path);
								}
							});
						});
					
				});
		$("#floorMgmtGrid").on("filter", function (event){
			rawfilterdata= $("#floorMgmtGrid").jqxGrid('getfilterinformation');
		}); 
	});
	
	function getSMSData(docno,gatebrhid){
		$.get('getSMSDetails.jsp',{'gatedocno':docno,'brhid':gatebrhid},function(data){
			data=JSON.parse(data);
			$('#smstext').text(data.msg);
		});
	}
</script>
<div id="floorMgmtGrid"></div>