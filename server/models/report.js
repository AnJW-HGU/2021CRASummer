'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Report extends Model {
    static associate(models) {
      // define association here
      this.belongsTo(models.Post, {
          foreignKey: 'post_id'
      });
      this.belongsTo(models.Comment, {
        foreignKey: 'comment_id'
      });
      this.belongsTo(models.Recomment, {
          foreignKey: 'recomment_id'
      });
      this.belongsTo(models.User, {
          foreignKey: 'user_id'
      });
    }
  };
  Report.init({
    id: {
      primaryKey: true,
      autoIncrement: true,
      type: DataTypes.INTEGER,
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
    modelName: 'Report',
    tableName: 'Reports',
    createdAt: 'written_date',
    updatedAt: 'revised_date',
  });
  return Report;
};
