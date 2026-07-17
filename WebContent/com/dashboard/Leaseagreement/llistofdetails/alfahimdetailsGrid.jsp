<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
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

  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();

	ClsleaseagreementDAO clad=new ClsleaseagreementDAO();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datasssss;
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 
	  dataildata='<%=clad.detailsgrids(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,outchk,inchk)%>';
 
	  datasssss='<%=clad.detailsgrid(barchval,fromdate,todate,cldocno,status,fleet,group,brand,model,outchk,inchk)%>';
	
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

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
     						{name : 'refname', type: 'String'},     						
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'vehdetails', type: 'String'}, 
     						{name : 'cldocno', type: 'String'  },
     						{name : 'outdate', type: 'date'  },
     						{name : 'outtime', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'reg_no', type: 'string'  },
                            {name : 'account', type: 'number'  },
                            {name : 'duration', type: 'string'  },
                            {name : 'clstatus', type: 'string'  },     						
     						{name : 'drname', type: 'String'  },
     						{name : 'mrno', type: 'String'  },
     						{name : 'rent', type: 'number'  },
     						{name : 'cdw', type: 'number'  },
     						{name : 'refnos', type: 'string'  },
     						{name : 'invdate', type: 'date'  },
     						{name : 'invrental', type: 'number'  },
     						{name : 'invcdw', type: 'number'  },
     						{name : 'project',type:'string'},
     						{name : 'originalfleet',type:'string'},
     						{name : 'originalchase',type:'String'},
     						{name : 'replacefleet',type:'String'},
     						{name : 'replacechase',type:'String'},
							{name : 'sal_name', type: 'string'  },
							{name : 'duedate', type: 'date'  },
							{name : 'indate', type: 'date'  },
     						{name : 'intime', type: 'string'  },
							{name : 'replaceregno', type: 'number'  },	
							{name : 'user_name', type: 'string'  },
     						{name : 'closeuser', type: 'string'  },
     						{name : 'vin',type:'string'},
     						{name : 'residualval',type:'number'},
     						{name : 'kmrest',type:'number'}
                          	],
                          	localdata: datasssss,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
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
            	
            	
            	width: '99%',
                height: 490,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                columnsresize: true,
                
     					
                columns: [
                          
      
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'LA NO', datafield: 'doc_no', width: '4%',hidden:true }, 
							{ text: 'LA NO', datafield: 'voc_no', width: '4%' },             
							{ text: 'Fleet', datafield: 'fleet_no', width: '5%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '14%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '6%' },
                            { text: 'Account', datafield: 'account', width: '6%' },
                            { text: 'Duration', datafield: 'duration', width: '6%' },
                            { text: 'Status', datafield: 'clstatus', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '18%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%'},
							{ text: 'Driver', datafield: 'drname', width: '10%'},
							{ text: 'Mob NO', datafield: 'per_mob', width: '9%'},
							{ text: 'Out Date', datafield: 'outdate', width: '7%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Out Time', datafield: 'outtime', width: '5%' },
							{ text: 'Ref No', datafield: 'refnos', width: '6%'},
							{ text: 'Manual LA', datafield: 'mrno', width: '6%'},
							{ text: 'In Date', datafield: 'indate', width: '7%',cellsformat:'dd.MM.yyyy'},
							{ text: 'In Time', datafield: 'intime', width: '5%' },
							{ text: 'Rent', datafield: 'rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
							{ text: 'CDW', datafield: 'cdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
							{ text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Inv Rent', datafield: 'invrental', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
							{ text: 'Inv CDW', datafield: 'invcdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
							{ text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
							{ text: 'Project', datafield: 'project', width: '10%'},
							{ text: 'Original Fleet',datafield:'originalfleet',width:'8%'},
							{ text: 'Original Chassis',datafield:'originalchase',width:'10%'},
							{ text: 'Replaced Fleet',datafield:'replacefleet',width:'8%'},
							{ text: 'Replaced Reg No',datafield:'replaceregno',width:'8%'},
							{ text: 'Replaced Chassis',datafield:'replacechase',width:'10%'},
							{ text: 'Open User', datafield: 'user_name', width: '15%'},
							{ text: 'Close User', datafield: 'closeuser', width: '12%'},
							{ text: 'Salesman', datafield: 'sal_name', width: '15%'},
							{ text: 'Due Date', datafield: 'duedate', width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'VSB No', datafield: 'vin', width: '8%'},
							{ text: 'RV', datafield: 'residualval', width: '8%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Contractual Mileage Allowance', datafield: 'kmrest', width: '8%',cellsformat:'dd.MM.yyyy',align:'right',cellsalign:'right'},
					]
            });


     	   $("#overlay, #PleaseWait").hide();
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>