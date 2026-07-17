<%@ page import="com.dashboard.operations.agreementlist.ClsagreementDAO"  %>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	
 	String catid = request.getParameter("catid")==null?"NA":request.getParameter("catid").trim(); 
 	
 	ClsagreementDAO cad=new ClsagreementDAO();
  	
 %> 
 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
       
    .whiteClass
    {
        background-color: #FFF;
    }
    
</style>
 
 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 

	  dataildata='<%=cad.detailsgrids(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type,outchk,inchk,catid)%>';
	 
	  datasssss='<%=cad.detailsgrid(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,type,outchk,inchk,catid)%>';

	  aa=0;
 }
  
 
  else
	  {
	  datasssss;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc', type: 'String'  },   //this is the agreement
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'vehdetails', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						
     						
     						{name : 'ddate', type: 'date'  },
     						{name : 'dtime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						{name : 'ofno', type: 'string'  },
     						{name : 'oreg_no', type: 'string'  },
     						{name : 'drname', type: 'String'  },
     						{name : 'mrno', type: 'String'  },
     						{name : 'rent', type: 'number'  },
     						{name : 'cdw', type: 'number'  },
     						{name : 'refnos', type: 'string'  },
     						
     						{name : 'indate', type: 'date'  },
     						{name : 'intime', type: 'String'  },
     						
     						{name : 'invdate', type: 'date'  },
     						{name : 'invrental', type: 'number'  },
     						{name : 'invcdw', type: 'number'  },
     						{name : 'project',type:'string'},
     						{name : 'originalfleet',type:'string'},
     						{name : 'originalchase',type:'String'},
     						{name : 'replacefleet',type:'String'},
     						{name : 'replacechase',type:'String'} ,
     						{name : 'sal_name', type: 'string'  },
     						{name : 'brch', type: 'string'  },
     						{name : 'crdp', type: 'string'  },
     						{name : 'invr', type: 'string'  },
     						{name : 'yom', type: 'string'  },
     						{name : 'rltype', type: 'string'  },
     						{name : 'locname', type: 'string'  },
     						{name : 'pai', type: 'number'  },
     						{name : 'user_name', type: 'string'  },
     						{name : 'closeuser', type: 'string'  },
     						
     						
                          	],
                          	localdata: datasssss,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            var cellclassname = function (row, column, value, data) {
               if (data.rltype == 'Rent') {
                	return "redClass";
                } 
                 else {
                	return "whiteClass";
        		}
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 540,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			                   { text: 'SL#', sortable: false, filterable: false, editable: false,   
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'RA NO', datafield: 'doc', width: '6%' ,cellclassname: cellclassname },   //voc no
							{ text: 'Branch', datafield: 'brch', width: '10%',cellclassname: cellclassname },
							{ text: 'Location', datafield: 'locname', width: '10%',cellclassname: cellclassname },
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%',cellclassname: cellclassname },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '13%',cellclassname: cellclassname },
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%',cellclassname: cellclassname },
							{ text: 'Contract Fleet', datafield: 'ofno', width: '8%',cellclassname: cellclassname },
							{ text: 'Contract Reg No', datafield: 'oreg_no', width: '8%',cellclassname: cellclassname },
							{ text: 'Client Name', datafield: 'refname', width: '18%',cellclassname: cellclassname },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%',cellclassname: cellclassname},
							{ text: 'Driver', datafield: 'drname', width: '10%',cellclassname: cellclassname},
							{ text: 'Mob NO', datafield: 'per_mob', width: '10%',cellclassname: cellclassname},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '7%' ,cellclassname: cellclassname},
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							
							 { text: 'Out Time', datafield: 'otime', width: '5%' ,cellclassname: cellclassname}, 
							
							 { text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
								
							 { text: 'DueTime', datafield: 'dtime', width: '5%',cellclassname: cellclassname },
							 { text: 'Ref No', datafield: 'refnos', width: '6%',hidden:true,cellclassname: cellclassname},
						     { text: 'Manual RA', datafield: 'mrno', width: '6%',cellclassname: cellclassname},
								{ text: 'In Date', datafield: 'indate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
								
								 { text: 'In Time', datafield: 'intime', width: '5%',cellclassname: cellclassname },
							{ text: 'Rent', datafield: 'rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
								{ text: 'CDW', datafield: 'cdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
								{ text: 'PAI', datafield: 'pai', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
								 { text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
									{ text: 'Inv Rent', datafield: 'invrental', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname,hidden:true},
									{ text: 'Inv CDW', datafield: 'invcdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname,hidden:true},
									
									
									{ text: 'Project', datafield: 'project', width: '12%',cellclassname: cellclassname},
									{ text: 'Original Engine No.',datafield:'originalfleet',width:'10%',cellclassname: cellclassname},
									{ text: 'Original Chassis',datafield:'originalchase',width:'10%',cellclassname: cellclassname},
									{ text: 'Replaced Fleet',datafield:'replacefleet',width:'8%',cellclassname: cellclassname,hidden:true},
									{ text: 'Replaced Chassis',datafield:'replacechase',width:'10%',cellclassname: cellclassname,hidden:true},
									
									
									{ text: 'Open User', datafield: 'user_name', width: '15%',cellclassname: cellclassname},
									{ text: 'Close User', datafield: 'closeuser', width: '12%',cellclassname: cellclassname},
									{ text: 'Salesman', datafield: 'sal_name', width: '15%',cellclassname: cellclassname},
									{ text: 'Credit Period', datafield: 'crdp', width: '8%',cellclassname: cellclassname },
									{ text: 'Inv Rule', datafield: 'invr', width: '8%',cellclassname: cellclassname },
									{ text: 'YOM', datafield: 'yom', width: '8%' ,cellclassname: cellclassname},
									
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
							 { text: 'RL Type', datafield: 'rltype', width: '10%',hidden:true },
					
								
								
							// regno contract,fleetno contract
					
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>