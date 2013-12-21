
/*
 +------------------------------------------------------------------------+
 | Phalcon Framework                                                      |
 +------------------------------------------------------------------------+
 | Copyright (c) 2011-2013 Phalcon Team (http://www.phalconphp.com)       |
 +------------------------------------------------------------------------+
 | This source file is subject to the New BSD License that is bundled     |
 | with this package in the file docs/LICENSE.txt.                        |
 |                                                                        |
 | If you did not receive a copy of the license and are unable to         |
 | obtain it through the world-wide-web, please send an email             |
 | to license@phalconphp.com so we can send you a copy immediately.       |
 +------------------------------------------------------------------------+
 | Authors: Andres Gutierrez <andres@phalconphp.com>                      |
 |          Eduar Carvajal <eduar@phalconphp.com>                         |
 +------------------------------------------------------------------------+
 */

namespace Phalcon\Mvc\Model\Validator;

/**
 * Phalcon\Mvc\Model\Validator\Numericality
 *
 * Allows to validate if a field has a valid numeric format
 *
 *<code>
 *use Phalcon\Mvc\Model\Validator\Numericality as NumericalityValidator;
 *
 *class Products extends Phalcon\Mvc\Model
 *{
 *
 *  public function validation()
 *  {
 *      this->validate(new NumericalityValidator(array(
 *          "field" => 'price'
 *      )));
 *      if (this->validationHasFailed() == true) {
 *          return false;
 *      }
 *  }
 *
 *}
 *</code>
 *
 */
class Numericality extends Phalcon\Mvc\Model\Validator implements Phalcon\Mvc\Model\ValidatorInterface
{
	/**
	 * Executes the validator
	 *
	 * @param Phalcon\Mvc\ModelInterface record
	 * @return boolean
	 */
	public function validate(<Phalcon\Mvc\ModelInterface> record) -> boolean
	{
 		var field, value, message, replacePairs;

		let field = this->getOption("field");
		if typeof field != "string" {
			throw new Phalcon\Mvc\Model\Exception("Field name must be a string");
		}
 
		let value = record->readAttribute(field);

                if this->isSetOption("allowEmpty") && empty(value) {
                    return true;
                }
 
		/**
		 * Check if the value is numeric using is_numeric in the PHP userland
		 */
		if !is_numeric(value) {
 
			/**
			 * Check if the developer has defined a custom message
			 */
			let message = this->getOption("message");
                        let replacePairs = [":field": field];
			if empty(message) {
				let message = "Value of field :field must be numeric";
			}
 
			this->appendMessage(strtr(message, replacePairs), field, "Numericality");
			return false;
		}
 
		return true;
 
	}
}
