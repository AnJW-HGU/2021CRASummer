const { Classification } = require('../models');
sequelize = require('sequelize');
const Op = sequelize.Op;

exports.searchClassifications = async (req, res) => {
	Classification.findAll({
		where: {
			[Op.or]: [
				{
					과목명: {
						[Op.like]: "%"+req.query.searchKeyword+"%"
					}
				}, {
					개설정보: {
						[Op.like]: "%"+req.query.searchKeyword+"%"
					}
				}
			]
		}
	}).then(result => {
		if(result)
			res.json(result);
		else
			res.json({"result": 0});
	});
}
