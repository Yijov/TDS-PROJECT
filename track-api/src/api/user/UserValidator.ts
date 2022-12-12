import Joi from "joi";
import { ObjectSchema } from "joi";
import { IUserSignInDTO } from "./UserModel";
const { joiPasswordExtendCore } = require("joi-password");
const joiPassword = Joi.extend(joiPasswordExtendCore);

const SigninSchema: Joi.ObjectSchema<IUserSignInDTO> = Joi.object({
  email: Joi.string().required(),
  password: joiPassword.string().required(),
});

const Validate = async (schema: ObjectSchema, DTO: {}) => {
  const validation = await schema.validate(DTO);
  validation.error?.message
    ? { valid: false, message: validation.error?.message }
    : { valid: true, message: "success" };
};

const ValidateSignInData = async (DTO: IUserSignInDTO) => {
  await Validate(SigninSchema, DTO);
};

export default ValidateSignInData;
