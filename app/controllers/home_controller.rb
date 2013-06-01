class HomeController < ApplicationController
	def index
		unless current_user
			redirect_to '/sign_in'
		end
	end
  
  def upload_epxorters

  end

  def report
  end

  def exporter_details
  	@exporters = Shipper.all
  end

  def exporter_export_details

  end

  def upload_path
  	if params[:upload_type] == Shipper::SELECT
	  	redirect_to "/upload_epxorters", :notice => "Please Select the Upload type"
	  elsif params[:attachment].blank?
	  	redirect_to "/upload_epxorters?upload_type=#{params[:upload_type]}", :notice => "Please Select the file to Upload"
	 	elsif File.extname(params[:attachment][:file].original_filename) != '.csv'
	 		redirect_to "/upload_epxorters?upload_type=#{params[:upload_type]}", :notice => "Please Upload a CSV File"
	  elsif params[:upload_type] == Shipper::EXPORTER
	  	total,no = Shipper.upload_shipper(params[:attachment][:file].tempfile)
	  	redirect_to "/upload_epxorters", :notice => "Sucessfully Uploaded, #{no} out of #{total}"
	  elsif params[:upload_type] == Shipper::EXPORTER_REPORT
	  	total,no = ShipperExportDetail.upload_shipper_export(params[:attachment][:file].tempfile)
	  	redirect_to "/upload_epxorters", :notice => "Sucessfully Uploaded"
	  end
  end
end
