'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Recomment extends Model {
        static associate(models) {
            // define association here
            this.hasMany(models.Report, {
                foreignKey: 'recomment_id'
            });
			this.belongsTo(models.Comment, {
                foreignKey: 'comment_id'
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
        }
    };
    Recomment.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        reports_count: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            allowNull: false,
        },
        deleted_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
        },
    }, {
        sequelize,
        modelName: 'Recomment',
        tableName: 'Recomments',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    });
    return Recomment;
};

