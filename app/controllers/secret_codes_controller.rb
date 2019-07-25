class SecretCodesController < ApplicationController
	load_and_authorize_resource

	# List secret codes
	def index
		@secret_codes = SecretCode.includes(:user).paginate(:page => params[:page])
		@secret_code = SecretCode.new
	end

	# Generate new secret codes
	def create
		max_num = secret_code_params[:number_of_codes].to_i
		@secret_codes = (1..max_num).map { SecretCode.new }
		respond_to do |format|
			SecretCode.transaction do
				success = @secret_codes.map(&:save)
				if success.all?
					format.js
				else
					format.js
				end
			end
		end
	end

	private

	def secret_code_params
		params.require(:secret_code).permit(:number_of_codes)
	end
end
