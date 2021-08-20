'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Cla_test extends Model {
    static associate(models) {
      // define association here
    }
  };
  Cla_test.init({
    학부: DataTypes.STRING,
	구분: DataTypes.STRING,
    과목코드: DataTypes.STRING,
    분반: DataTypes.STRING,
    과목명: DataTypes.STRING,
    학점: DataTypes.STRING,
    개설정보: DataTypes.STRING,
    시간: DataTypes.STRING,
    강의실: DataTypes.STRING,
    정원: DataTypes.STRING,
    인원: DataTypes.STRING,
    영어: DataTypes.STRING,
    교양: DataTypes.STRING,
    성적유형: DataTypes.STRING,
    PF병행: DataTypes.STRING,
    강의: DataTypes.STRING,
    비고: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Cla_test',
  });
  return Cla_test;
};
