'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Inquiry extends Model {
    static associate(models) {
      // define association here
      this.hasMany(models.Photo, {
        foreignKey: 'inquiry_id'
      });
	  this.belongsTo(models.Post, {
        foreignKey: 'post_id'
      });
	  this.belongsTo(models.User, {
        foreignKey: 'user_id'
      });
    }
  };
  Inquiry.init({
        kind: {
            type: DataTypes.STRING,
            allowNull: false
        },
        title: {
            type: DataTypes.STRING,
            allowNull: false
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false
        },
        completed_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
        },
        deleted_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
        }
    }, {
        sequelize,
        modelName: 'Inquiry',
        tableName: 'Inquiries',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    });
    return Inquiry;
};
