'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Classification extends Model {
        static associate(models) {
            // define association here
          this.hasMany(models.Post);
            // hasMany(Preferred_subjects);
        }
  };
  Classification.init({
    id: {
        primaryKey: true,
        autoIncrement: true,
        type: DataTypes.SMALLINT,
        allowNull: false
    },
    domain: {
        type: DataTypes.STRING(5),
        allowNull: false,
    },
    major: {
        type: DataTypes.STRING(15),
        allowNull: false,
    },
    subject: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
    professor_name: {
        type: DataTypes.STRING(65),
        allowNull: false,
    }
  }, {
      sequelize,
      modelName: 'Classification',
      tableName: 'Classifications',
  });
  return Classification;
};

