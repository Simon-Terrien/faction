<%@page import="org.apache.struts2.components.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="bs" uri="/WEB-INF/BootStrapHandler.tld"%>
<style>
.fa-caret-down {
	position: absolute !important;
	top: 30% !important;
	right: 0;
	padding-right: 10px;
}

.bcaret {
	width: 150px;
}
</style>

<!-- left column -->
<div class="col-md-12">
	<!-- general form elements -->
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">Vulnerabilities</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<button class="btn btn-block btn-info btn-lg" id="addVuln">Add
				Vulnerability</button>
			<br>
			<table id="vulnTable"
				class="table table-striped table-hover dataTable">
				<thead class="theader">
					<tr>
						<th>Name</th>
						<th>Severity</th>
						<th>Active?</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="vulnerabilities">
						<tr>
							<td><s:property value="name" /></td>
							<td><s:property value="updateRiskLevels()" /> <s:property
									value="overallStr" /></td>
							<td><input class="" type="checkbox"
								onclick="toggleVuln(${id },${active == false ? 'false' : 'true'})"
								${active == false ? '' : 'checked'}></input></td>
							<td><span class="vulnControl" onclick="editVuln(${id})">
									<i class="fa fa-edit"></i>
							</span> <span class="vulnControl vulnControl-delete"
								onclick="deleteVuln(${id})"> <i class="fa fa-trash"></i>
							</span></td>
							<td><s:property value="overall" /></td>
							<td>${active == false ? 'disabled' : 'active'}></td>
						</tr>
					</s:iterator>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	</div>
	<!-- /.box -->
</div>

<!-- Add Vulnerablity Modal -->

<div class="modal" id="vulnModal">
	<div class="modal-dialog" style="width: 75%">
		<div class="modal-content">
			<div class="modal-header bg-red">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">
					<b><i class="fa fa-bug"></i> Vulnerability Entry Form</b>
				</h4>
			</div>
			<div class="modal-body bg-red">
				<form>
					<div class="form-horizontal">
						<div class="box-body">
							<div class="form-group">
								<label for="title" class="col-sm-2 control-label">Title:
									*</label>
								<div class="col-sm-4 control-label">
									<input class="form-control" id="title"
										placeholder="Vulnerbility Name" />
								</div>
								<label for="title" class="col-sm-2 control-label">Overall
									Severity: *</label>
								<div class="col-sm-4">
									<select class="select2 form-control" id="overall"
										style="width: 100%">
										<s:iterator value="levels" status="stat">
											<s:if
												test="risk != null && risk != 'Unassigned' && risk != ''">
												<option value="${stat.index}">${risk}</option>
											</s:if>
										</s:iterator>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 control-label">Category: *</label>
								<div class="col-sm-4">
									<select class="form-control select2" style="width: 100%;"
										id="catNameSelect">
										<s:iterator value="categories">
											<option value="<s:property value=" id" />">
												<s:property value="name" />
											</option>
										</s:iterator>
									</select>
								</div>

								<label for="title" class="col-sm-2 control-label">Impact
									Severity: *</label>
								<div class="col-sm-4">
									<select class="select2 form-control" id="impact"
										style="width: 100%">
										<s:iterator value="levels" status="stat">
											<s:if
												test="risk != null && risk != 'Unassigned' && risk != ''">
												<option value="${stat.index}">${risk}</option>
											</s:if>
										</s:iterator>
									</select>
								</div>
							</div>
							<!-- /.form-group -->
						</div>
						<div class="form-group">
							<div class="col-sm-6"></div>
							<label for="title" class="col-sm-2 control-label">Likelihood
								Severity: *</label>
							<div class="col-sm-4">
								<select class="select2 form-control" id="likelyhood"
									style="width: 100%">
									<s:iterator value="levels" status="stat">
										<s:if
											test="risk != null && risk != 'Unassigned' && risk != ''">
											<option value="${stat.index}">${risk}</option>
										</s:if>
									</s:iterator>
								</select>
							</div>
						</div>
						<br>


						<div class="row">
							<!-- Vuln Description Section -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header">
										<h3 class="box-title">
											<i class="glyphicon glyphicon-edit"></i> Vulnerability
											Description: *<small></small>
										</h3>
									</div>
									<!-- /.box-header -->
									<div class="box-body pad">
										<textarea id="description" name="description" rows="10"
											cols="80">

                    </textarea>
									</div>
								</div>
								<!-- /.box -->
							</div>
						</div>
						<div class="row">
							<!-- Vuln Recommendation Section -->
							<div class="col-md-12">
								<div class="box box-info">
									<div class="box-header">
										<h3 class="box-title">
											<i class="glyphicon glyphicon-edit"></i> Vulnerability
											Recommendation: *<small></small>
										</h3>
									</div>
									<!-- /.box-header -->
									<div class="box-body pad">
										<textarea id="recommendation" name="recommendation" rows="10"
											cols="80">

                    					</textarea>
									</div>
								</div>
								<!-- /.box -->
							</div>
						</div>
					</div>
				</form>
			</div>
			<!-- /.box-body -->
			<div class="modal-footer bg-red">
				<button type="button" class="btn btn-default pull-left"
					data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="saveVuln">
					<i class="fa fa-save"></i> Save changes
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->