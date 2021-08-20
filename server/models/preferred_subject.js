'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Preferred_subject extends Model {
        static associate(models) {
            // define association here
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
            this.belongsTo(models.Classification, {
                foreignKey: 'classification_id'
            });
        }
    };
    Preferred_subject.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
        }
    }, {
        sequelize,
        modelName: 'Preferred_subject',
        tableName: 'Preferred_subjects',
        timestamps: false,
    });
    return Preferred_subject;
};
